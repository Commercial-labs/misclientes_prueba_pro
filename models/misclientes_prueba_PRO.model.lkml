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
  label: "Citas"
  persist_with: tx_datagroup

  join: centros {
    type: left_outer
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
