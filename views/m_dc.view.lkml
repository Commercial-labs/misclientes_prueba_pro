view: m_dc {

  # sql_table_name: `CENTROS_JER` ;;
  label: "Maestro DCs"

  dimension: cod_dc {
    primary_key: yes
    label: "Código DC"
    type: number
    # sql: ${TABLE}.COD_DG ;;
    sql:  ${centros.cod_dc} ;;
  }

  dimension: des_dc {
    label: "DC"
    type: string
    # sql: ${TABLE}.DES_DG) ;;
    sql:  ${centros.des_dc} ;;
  }
}
