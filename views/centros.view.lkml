include: "/views/centros_1.view"
include: "/views/centros_2.view"

view: centros {

  extends: [centros_1, centros_2]

  dimension: pk_centro {
    primary_key: yes
    label: "Código oficina"
    type: number
    # sql: ${TABLE}.PK_CENTRO ;;
  }

}
