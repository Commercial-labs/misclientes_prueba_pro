# The name of this view in Looker is "M Empleados"
view: m_empleados {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `M_EMPLEADOS` ;;
  label: "Empleados"

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Nombre Empleado" in Explore.

  dimension: nombre_empleado {
    label: "Nombre empleado"
    type: string
    sql: ${TABLE}.NOMBRE_EMPLEADO ;;
  }

  dimension: tipo_gestor {
    label: "Tipo Gestor"
    type: string
    sql: ${TABLE}.TIPO_GESTOR ;;
  }

  dimension: usuario {
    primary_key: yes
    label: "Identificador empleado"
    type: number
    sql: ${TABLE}.USUARIO ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
  }
}
