# include: "centros.view"
view: m_oficina {
  # extends: [centros]
  sql_table_name: `SEG_LATERAL_OFICINA` ;;
  label: "Maestro Oficinas"

  dimension: cod_oficina {
    primary_key: yes
    label: "Código oficina"
    type: number
    sql: ${TABLE}.COD_OFICINA ;;
    # sql:  ${cod_oficina} ;;
  }

  dimension: des_oficina {
    label: "Oficina"
    type: string
    sql: ${TABLE}.DES_OFICINA) ;;
    # sql:   ${des_oficina} ;;
  }

  dimension: centro_emp {
    label: "Centro empleado"
    type: number
    sql: ${TABLE}.CENTRO_EMP ;;
  }
}
