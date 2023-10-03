view: seg_lateral_v2 {
  sql_table_name: `SEG_LATERAL` ;;
  label: "Seguridad lateral"

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Nombre Empleado" in Explore.

  dimension: centro_emp {
    label: "Centro empleado"
    type: number
    sql: ${TABLE}.CENTRO_EMP ;;
  }

  dimension: rol {
    label: "Rol empleado"
    type: string
    sql: ${TABLE}.ROL ;;
  }

  dimension: centro {
    label: "Centro"
    type: number
    sql: ${TABLE}.CENTRO ;;
  }

  dimension: nivel_centro {
    label: "Nivel centro"
    type: string
    sql: ${TABLE}.NIVEL_CENTRO ;;
  }
}
