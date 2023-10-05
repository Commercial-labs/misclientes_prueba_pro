# include: "centros.view"
view: m_dc {
  # extends: [centros]
  sql_table_name: `SEG_LATERAL_DC` ;;
  label: "Maestro DCs"

  dimension: cod_dc {
    # primary_key: yes
    label: "Código DC"
    type: number
    sql: ${TABLE}.COD_DC ;;
    # sql:  ${cod_dc} ;;
  }

  dimension: des_dc {
    label: "DC"
    type: string
    sql: ${TABLE}.DES_DC) ;;
    # sql:   ${des_dc} ;;
  }

  dimension: centro_emp {
    label: "Centro empleado"
    type: number
    sql: ${TABLE}.CENTRO_EMP ;;
  }
}
