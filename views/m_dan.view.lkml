# include: "centros.view"
view: m_dan {
  # extends: [centros]
  sql_table_name: `SEG_LATERAL_DAN` ;;
  label: "Maestro DANs"

  dimension: cod_dan {
    primary_key: yes
    label: "Código DAN"
    type: number
    sql: ${TABLE}.COD_DAN ;;
    # sql:  ${cod_dan} ;;
  }

  dimension: des_dan {
    label: "DAN"
    type: string
    sql: ${TABLE}.DES_DAN) ;;
    # sql:   ${des_dan} ;;
  }

  dimension: centro_emp {
    label: "Centro empleado"
    type: number
    sql: ${TABLE}.CENTRO_EMP ;;
  }
}
