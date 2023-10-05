# include: "centros.view"
view: m_dt {
  # extends: [centros]
  sql_table_name: `SEG_LATERAL_DT` ;;
  label: "Maestro DTs"

  dimension: cod_dt {
    # primary_key: yes
    label: "Código DT"
    type: number
    sql: ${TABLE}.COD_DT ;;
    # sql:  ${cod_dt} ;;
  }

  dimension: des_dt {
    label: "DT"
    type: string
    sql: ${TABLE}.DES_DT) ;;
    # sql:   ${des_dt} ;;
  }

  dimension: centro_emp {
    label: "Centro empleado"
    type: number
    sql: ${TABLE}.CENTRO_EMP ;;
  }
}
