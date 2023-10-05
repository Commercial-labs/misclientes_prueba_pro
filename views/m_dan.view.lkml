view: m_dan {

  sql_table_name: 'CENTROS' ;;
  label: "Maestro DANs"

  dimension: cod_dan {
    primary_key: yes
    label: "Código DAN"
    type: number
    sql: ${TABLE}.COD_DAN ;;
  }

  dimension: des_dan {
    label: "DAN"
    type: string
    sql: ${TABLE}.DES_DAN) ;;
  }
}
