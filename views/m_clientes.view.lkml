# The name of this view in Looker is "M Clientes"
view: m_clientes {
  # The  sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `PoC_Mis_Clientes.M_CLIENTES` ;;
  label: "Clientes"

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Cod Negocio" in Explore.

  dimension: cod_negocio {
    label: "Negocio"
    type: string
    sql: ${TABLE}.COD_NEGOCIO ;;
  }

  dimension: nombre_cliente {
    label: "Nombre cliente"
    type: string
    sql: ${TABLE}.NOMBRE_PERSONA_FISICA ;;
  }

  dimension: numperso {
    primary_key: yes
    label: "Numperso"
    type: number
    sql: ${TABLE}.NUMPERSO ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
  }
}
