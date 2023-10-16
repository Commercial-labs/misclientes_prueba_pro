test: minimo_total_citas {
  explore_source:  tx_eventos {
    column:  count {
      field:  tx_eventos.count
    }
  }
  assert:  count_is_expected_value {
    expression: ${tx_eventos.count} > 100 ;;
  }
}
