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

  # access_filter: {
  #   field: seg_lateral_oficina.centro_emp
  #   user_attribute: centro_empleado
  # }

  # access_filter: {
  #   field: seg_lateral_dan.centro_emp
  #   user_attribute: centro_empleado
  # }

  # access_filter: {
  #   field: seg_lateral_dc.centro_emp
  #   user_attribute: centro_empleado
  # }

  # access_filter: {
  #   field: seg_lateral_dt.centro_emp
  #   user_attribute: centro_empleado
  # }


  # join: seg_lateral_oficina {
  #   from: seg_lateral
  #   sql_on: {% if _user_attributes['tipo_centro_empleado'] == 'DT' %}
  #               ${centros.cod_dt}
  #             {% elsif _user_attributes['tipo_centro_empleado'] == 'DC' %}
  #               ${centros.cod_dc}
  #             {% elsif _user_attributes['tipo_centro_empleado'] == 'DAN' %}
  #               ${centros.cod_dan}
  #             {% else %}
  #               ${tx_eventos.centro}
  #             {% endif %}
  #             = ${seg_lateral.centro};;
  # }

  # join: seg_lateral {
  #   type: inner
  #   # sql_on: {% if _user_attributes['tipo_centro_empleado'] == 'DT' and  _view._name.nivel_centro == 'DC' %}

  #   sql_on:
  #           {% case _user_attributes['tipo_centro_empleado']%}
  #             {% when 'DT' %}
  #               ${m_dt.cod_dt}
  #             {% when 'DC' %}
  #               ${m_dc.cod_dc}
  #             {% when 'DAN' %}
  #               ${m_dan.cod_dan}
  #             {% when 'Oficina' %}
  #               ${m_oficina.cod_oficina}
  #             {% else %}
  #               ${tx_eventos.centro}
  #           {% endcase %}
  #           = ${seg_lateral.centro} ;;
  #   relationship: many_to_many
  # }

  join: m_dt {
    type: inner
    sql_on: ${tx_eventos.cod_dt}=${m_dt.cod_dt} ;;
    relationship: many_to_one
  }

  join: m_dc {
    type: inner
    sql_on: ${tx_eventos.cod_dc}=${m_dc.cod_dc} ;;
    relationship: many_to_one
  }

  join: m_dan {
    type: inner
    sql_on: ${tx_eventos.cod_dan}=${m_dan.cod_dan} ;;
    relationship: many_to_one
  }

  join: m_oficina {
    type: inner
    sql_on: ${tx_eventos.centro}=${m_oficina.cod_oficina} ;;
    relationship: many_to_one
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
