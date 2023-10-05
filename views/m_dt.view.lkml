view: m_dt {

  sql_table_name: `CENTROS_JER` ;;
  label: "Maestro DTs"

  dimension: cod_dt {
    primary_key: yes
    label: "Código DT"
    type: number
    sql: ${TABLE}.COD_DT ;;
  }

  dimension: des_dt {
    label: "DT"
    type: string
    sql: ${TABLE}.DES_DT) ;;
  }
}
