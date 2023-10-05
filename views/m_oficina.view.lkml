view: m_oficina {

  sql_table_name: `CENTROS_JER` ;;
  label: "Maestro Oficinas"

  dimension: cod_oficina {
    primary_key: yes
    label: "Código oficina"
    type: number
    sql: ${TABLE}.PK_CENTRO ;;
  }

  dimension: des_oficina {
    label: "Oficina"
    type: string
    sql: ${TABLE}.DES_CENTRO_GES) ;;
  }
}
