view: m_dc {

  sql_table_name: 'CENTROS' ;;
  label: "Maestro DCs"

  dimension: cod_dc {
    primary_key: yes
    label: "Código DC"
    type: number
    sql: ${TABLE}.COD_DG ;;
  }

  dimension: des_dc {
    label: "DC"
    type: string
    sql: ${TABLE}.DES_DG) ;;
  }
}
