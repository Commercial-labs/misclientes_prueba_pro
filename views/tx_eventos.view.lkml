# The name of this view in Looker is "Tx Eventos"
view: tx_eventos {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `TX_EVENTOS` ;;
  label: "Citas"

  # filter: select_DT {
  #   type: string
  #   suggest_explore: tx_eventos
  #   suggest_dimension: centros.des_dt
  #   default_value: "9000 - OFICINES VIRTUALS"
  # }

  # filter: select_DC {
  #   type: string
  #   suggest_explore: tx_eventos
  #   suggest_dimension: centros.des_dc
  # }

  # filter: select_DAN {
  #   type: string
  #   suggest_explore: tx_eventos
  #   suggest_dimension: centros.des_dan
  # }

  filter: select_oficina {
    type: string
    suggest_explore: tx_eventos
    suggest_dimension: centros.des_centro
  }

  filter: select_medida {
    label: "Datos"
    type: string
    suggestions: ["Citas", "Citas por empleado"]
  }

  filter: select_dimension {
    label: "Tiempo"
    type: string
    suggestions: ["Mensual", "Semanal","Diario"]
  }

  parameter: select_drill {
    label: "Drill down"
    type: unquoted
    suggestions: ["DT", "DC","DAN","Oficina"]
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(CAST(${TABLE}.ID_EVENTO AS STRING),"-",CAST(${TABLE}.CENTRO AS STRING),"-", CAST(${TABLE}.EMPLEADO AS STRING),"-",CAST(${TABLE}.NUMPERSO AS STRING))  ;;

  }

  dimension: canal {
    label: "Canal"
    type: string
    sql: ${TABLE}.CANAL ;;
  }

  dimension: centro {
    label: "Centro"
    type: number
    sql: ${TABLE}.CENTRO ;;
  }

  dimension: empleado {
    label: "Identificador Empleado"
    type: number
    sql: ${TABLE}.EMPLEADO ;;
  }

  dimension: estado {
    label: "Estado"
    type: string
    sql: ${TABLE}.ESTADO ;;
    case: {
      when: {
        sql: ${TABLE}.ESTADO = "Cita Planificada" ;;
        label: "Cita Planificada"
      }
      when: {
        sql: ${TABLE}.ESTADO = "Cerrada" ;;
        label: "Cerrada"
      }
    }
  }

  dimension: expectativa_venta {
    label: "Expectativa venta"
    type: string
    sql: ${TABLE}.PRODUCTO ;;
  }

  dimension: experiencia {
    label: "Experiencia"
    type: string
    sql: ${TABLE}.EXPERIENCIA ;;
  }

  dimension_group: fecha_cita {
    label: "Fecha cita"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.FECHA_CITA ;;
  }

  dimension: finalidad {
    label: "Finalidad"
    type: string
    sql: ${TABLE}.FINALIDAD ;;
  }

  dimension: hora_cita {
    label: "Hora cita"
    type: string
    sql: ${TABLE}.HORA_CITA ;;
  }

  dimension: id_evento {
    # primary_key: yes
    label: "Identificador evento"
    type: number
    sql: ${TABLE}.ID_EVENTO ;;
  }

  dimension: id_oportunidad {
    label: "Oportunidad asociada"
    type: number
    sql: ${TABLE}.ID_OPORTUNIDAD ;;
    link: {
      label: "Detalle oportunidad"
      url: "https://www.google.com/search?q={{ value }}"
    }
  }

  dimension: numperso {
    label: "Numperso"
    type: number
    sql: ${TABLE}.NUMPERSO ;;
  }

  dimension: origen {
    label: "Origen"
    type: string
    sql: ${TABLE}.ORIGEN ;;
    case: {
      when: {
        sql: ${TABLE}.ORIGEN = "Gestor" ;;
        label: "Gestor"
      }
      when: {
        sql: ${TABLE}.ORIGEN = "Cliente" ;;
        label: "Cliente"
      }
      when: {
        sql: ${TABLE}.ORIGEN = "Desconocido" ;;
        label: "Desconocido"
      }
    }
  }

  dimension: planificacion {
    label: "Planificación"
    type: string
    sql: ${TABLE}.PLANIFICACION ;;
  }

  dimension: producto {
    label: "Producto"
    type: string
    sql: ${TABLE}.EXPECTATIVA_VENTA ;;
  }

  dimension: tipo_contacto {
    label: "Tipo contacto"
    type: string
    sql: ${TABLE}.TIPO_CONTACTO ;;
  }

  dimension: num_oportunidades {
    label: "Número oportunidades"
    type: string
    sql: "1 oportunidad" ;;
  }

  dimension: periodo {
    sql:
      CASE
       WHEN {% condition select_dimension %}
        "Mensual"
        {% endcondition %}
      THEN  ${fecha_cita_month}
          WHEN {% condition select_dimension %}
        "Semanal"
        {% endcondition %}
      THEN  ${fecha_cita_week}
      WHEN {% condition select_dimension %}
        "Diario"
        {% endcondition %}
      THEN FORMAT_DATE('%Y-%m-%d',${fecha_cita_date})
      ELSE  ${fecha_cita_week}
      END;;
  }
  dimension: drill_down {
    label: "{% parameter select_drill %}"
    sql:
    CASE
      WHEN {% condition select_drill %}
        "DT"
        {% endcondition %}
      THEN  ${centros.des_dt}
      WHEN {% condition select_drill %}
        "DC"
        {% endcondition %}
      THEN  ${centros.des_dc}
      WHEN {% condition select_drill %}
        "DAN"
      {% endcondition %}
      THEN ${centros.des_dan}
      WHEN {% condition select_drill %}
        "Oficina"
      {% endcondition %}
      THEN ${centros.des_centro}
      ELSE ${centros.des_dt}
    END;;
  }

  measure: medida_final {
    type: number
    sql:
      CASE
      WHEN {% condition select_medida %}
        "Citas"
        {% endcondition %}
      THEN ${count}
      WHEN {% condition select_medida %}
        "Citas por empleado"
        {% endcondition %}
      THEN ${media_empleado}
      ELSE ${count}
      END
      ;;
  }

  # measure: total_medida{
  #   type: number
  #   sql:
  #     CASE
  #     WHEN ${TABLE}.ESTADO = "Cita Planificada" OR ${TABLE}.ESTADO = "Cerrada"
  #     THEN SUM(${medida_final})
  #     END
  #   ;;
  # }

  measure: count {
    type: count
  }

  measure: media_empleado {
    label: "Media empleados"
    type: number # El resultado será un número decimal
    # sql: ${tx_eventos.count}/${centros.total_num_emp} ;;
    sql:
      CASE
      WHEN ${centros.total_num_emp} = 0
      THEN 0  -- ${tx_eventos.count} modifica el gráfico
      ELSE round(${tx_eventos.count}/${centros.total_num_emp}, 2)
      END;;

    # description: "Media por empleado"
    # value_format: "0.00" # Formato para mostrar el resultado con 2 decimales
  }

}
