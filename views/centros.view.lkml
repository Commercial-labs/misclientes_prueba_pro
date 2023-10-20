datagroup: tm_centros_datagroup {
  max_cache_age: "24 hours"
  sql_trigger: SELECT max(PK_CENTRO) FROM CENTROS ;;
}

# The name of this view in Looker is "Centros"
view: centros {
  fields_hidden_by_default: yes

  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  label: "Centros"
  derived_table:{
    sql:
        SELECT DISTINCT
          COD_DT,
          DES_DT,
          COD_DAN,
          DES_DAN,
          COD_DG,
          DES_DG,
          CENTROS_JER.PK_EMPRESA,
          CENTROS_JER.PK_CENTRO,
          DES_CENTRO_GES,
          CENTROS.FK_TIPOLOGIA_CTM,
          FK_TIPO_OFICINA,
          IND_CENTRO_EMPRESA,
          IND_OFI_BANCA_PRIVADA,
          IND_OFI_CORPORATIVA,
          IND_CENTRO_INSTITUCIONES,
          IND_CENTRO_PROMOTORES,
          EMPMESAJ_AE62ACAB AS NUM_EMP
        FROM CENTROS
        Left Join CENTROS_JER ON
          CENTROS.PK_CENTRO = CENTROS_JER.PK_CENTRO
        Left Join NUM_EMP ON
          CENTROS.PK_CENTRO = NUM_EMP.CENTRO_2C8AA2D4
        where CENTROS.PK_EMPRESA = 1
          and FECHA_BAJA_CENTRO is null
          and DES_RED = 'TOTAL RED TERRITORIAL'
          and FK_TIPO_CENTRO in ('OF')
          and FK_SITUACION_CENTRO in (10)
          and FK_TIPO_CENTRO_SUPERIOR in ('OF', 'GC') ;;
    datagroup_trigger: tm_centros_datagroup
  }

  dimension: pk_centro {
    primary_key: yes
    label: "Código oficina"
    type: number
    sql: ${TABLE}.PK_CENTRO ;;
  }

  dimension: des_centro {
    label: "Oficina"
    type: string
    sql: CONCAT(${pk_centro}, " - ", ${TABLE}.DES_CENTRO_GES) ;;
  }

  dimension: cod_dan {
    label: "Código DAN"
    type: number
    sql: ${TABLE}.COD_DAN ;;
  }

  dimension: des_dan {
    label: "DAN"
    type: string
    sql: CONCAT(${cod_dan}, " - ", ${TABLE}.DES_DAN) ;;
  }

  dimension: cod_dc {
    label: "Código DC"
    type: number
    sql: ${TABLE}.COD_DG ;;
  }

  dimension: des_dc {
    label: "DC"
    type: string
    sql: CONCAT(${cod_dc}, " - ", ${TABLE}.DES_DG) ;;
  }

  dimension: cod_dt {
    label: "Código DT"
    type: number
    sql: ${TABLE}.COD_DT ;;
  }

  dimension: des_dt {
    label: "DT"
    type: string
    sql: CONCAT(${cod_dt}, " - ", ${TABLE}.DES_DT) ;;
  }

  dimension: num_emp {
    label: "Número empleados"
    type: number
    sql: ${TABLE}.NUM_EMP ;;
  }

  dimension: tipo_oficina {
    label: "Tipo Oficina"
    type: string
    sql: CASE
          WHEN ${TABLE}.IND_CENTRO_EMPRESA = 1 and ${TABLE}.FK_TIPO_OFICINA = '4' THEN 'CENI'
          WHEN ${TABLE}.IND_CENTRO_EMPRESA = 1 and ${TABLE}.FK_TIPO_OFICINA = 'O' THEN 'Day One'
          WHEN ${TABLE}.IND_CENTRO_EMPRESA = 1 THEN 'Empresas'
          WHEN ${TABLE}.IND_OFI_BANCA_PRIVADA = 1 and ${TABLE}.FK_TIPO_OFICINA = 'W' THEN 'Wealth'
          WHEN ${TABLE}.IND_OFI_BANCA_PRIVADA = 1 THEN 'Banca Privada'
          WHEN ${TABLE}.IND_OFI_CORPORATIVA = 1 THEN 'Corporativa'
          WHEN ${TABLE}.IND_CENTRO_INSTITUCIONES = 1 THEN 'Instituciones'
          WHEN ${TABLE}.IND_CENTRO_PROMOTORES = 1 THEN 'Promotores'
          WHEN ${TABLE}.FK_TIPO_OFICINA = 'W' THEN 'Wealth'
          WHEN ${TABLE}.FK_TIPO_OFICINA = '6' THEN 'Instituciones'
          WHEN ${TABLE}.FK_TIPO_OFICINA = '1' or ${TABLE}.FK_TIPO_OFICINA = '9' THEN 'Store Premier'
          WHEN ${TABLE}.FK_TIPO_OFICINA = '5' THEN 'Store Negocios'
          WHEN ${TABLE}.FK_TIPO_OFICINA = 'M' THEN 'Store Pymes'
          WHEN ${TABLE}.FK_TIPO_OFICINA = 'A' or ${TABLE}.FK_TIPO_OFICINA = 'B' or ${TABLE}.FK_TIPO_OFICINA = '8' THEN 'Store'
          WHEN ${TABLE}.FK_TIPO_OFICINA = 'I' THEN 'Intouch'
          ELSE 'Retail'
        END ;;
  }

  measure: total_num_emp {
    label: "Total empleados"
    type: sum
    sql: ${num_emp} ;;
  }


  measure: count {
    type: count
  }

}
