# Define the database connection to be used for this model.
# prueba
connection: "misclientes_bigquery_pro"

# include all the views
include: "/views/**/*.view.lkml"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.
# Hello world

datagroup: tx_datagroup {
  # sql_trigger: SELECT MAX(fecha_ingesta) FROM tx_eventos;;
  max_cache_age: "1 hour"
}

explore: tx_eventos {
  label: "Citas_PRO"
  persist_with: tx_datagroup

  # Formas de filtrar los datos:

  # sql_always_having:  ;;

  # SUBSTR({{ _user_attributes['centro_empleado'] }}, STRPOS({{ _user_attributes['centro_empleado'] }}, '-'))
  # sql_always_where: CAST(SUBSTR({{ _user_attributes['centro_empleado'] }}, STRPOS({{ _user_attributes['centro_empleado'] }}, '-')) AS INT64) = ${seg_lateral.centro_emp} ;;

  # always_filter: {}
  # conditionally_filter: {}

  access_filter: {
    field: seg_lateral.centro_emp
    user_attribute: centro_empleado
  }

  # join: seg_lateral_v2 {
  #   type: inner
  #   sql_on: {% if _user_attributes['tipo_centro_empleado'] == 'DT' %}
  #             ${centros.cod_dt}
  #           {% elsif _user_attributes['tipo_centro_empleado'] == 'DC' %}
  #             ${centros.cod_dc}
  #           {% elsif _user_attributes['tipo_centro_empleado'] == 'DAN' %}
  #             ${centros.cod_dan}
  #           {% else %}
  #             ${tx_eventos.centro}
  #           {% endif %}
  #           = ${seg_lateral_v2.centro};;
  #   relationship: many_to_many
  # }

  join: seg_lateral {
    type: inner
    sql_on: {% if _user_attributes['tipo_centro_empleado'] == 'DT' and seg_lateral_v2.nivel_centro == 'DC' %}
              ${centros.cod_dc}
            {% elsif _user_attributes['tipo_centro_empleado'] == 'DC' %}
              ${centros.cod_dan}
            {% else %}
              ${tx_eventos.centro}
            {% endif %}
            = ${seg_lateral.centro} ;;
    relationship: many_to_many
  }

  join: centros {
    type: inner
    sql_on: ${tx_eventos.centro}=${centros.pk_centro} ;;
    relationship: many_to_one
  }

  join: m_clientes {
    type: inner
    sql_on: ${tx_eventos.numperso}=${m_clientes.numperso} ;;
    relationship: many_to_one
  }

  join: m_empleados {
    type: inner
    sql_on: ${tx_eventos.empleado}=${m_empleados.usuario} ;;
    relationship: many_to_one
  }
}
