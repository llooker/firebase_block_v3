- dashboard: firebase_dashboard
  title: Firebase Dashboard
  layout: newspaper
  elements:
  - title: Average Session Length
    name: Average Session Length
    model: firebase
    explore: events
    type: single_value
    fields: [sessions.average_session_length]
    limit: 500
    query_timezone: America/Los_Angeles
    series_types: {}
    row: 0
    col: 0
    width: 8
    height: 3
  - title: Avg First Session Length
    name: Avg First Session Length
    model: firebase
    explore: events
    type: single_value
    fields: [sessions.average_first_session_length]
    limit: 500
    query_timezone: America/Los_Angeles
    series_types: {}
    row: 0
    col: 8
    width: 8
    height: 3
  - title: MAU
    name: MAU
    model: firebase
    explore: events
    type: looker_column
    fields: [events.number_of_users, events.event_month]
    fill_fields: [events.event_month]
    sorts: [events.event_month desc]
    limit: 500
    column_limit: 50
    series_types: {}
    row: 0
    col: 16
    width: 8
    height: 5
  - title: Retention by Signup Cohort
    name: Retention by Signup Cohort
    model: firebase
    explore: events
    type: looker_line
    fields: [events.retention_day, events.number_of_users, events.user_first_touch_week]
    pivots: [events.user_first_touch_week]
    fill_fields: [events.user_first_touch_week]
    filters:
      events.user_first_touch_month: 2018/06/11 to 2018/07/16
      events.retention_day: "[0, 30]"
    sorts: [events.retention_day, events.user_first_touch_week]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: still_active, label: "% still active", expression: "${events.number_of_users}/max(${events.number_of_users})",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: still_active, id: 2018-06
              - still_active, name: 2018-06}, {axisId: still_active, id: 2018-07 -
              still_active, name: 2018-07}, {axisId: still_active, id: 2018-08 - still_active,
            name: 2018-08}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: log}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1f3e5a",
        font_color: !!null '', color_application: {collection_id: 960ff0d9-39cb-4672-8b58-7d0d70c0384d,
          palette_id: fe72a87f-9ecc-4b2e-810c-874e1fda1697, options: {steps: 5, constraints: {
              min: {type: number, value: 0.25}, mid: {type: number, value: 0}, max: {
                type: percentile, value: 20}}, mirror: false, reverse: true, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [still_active]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [events.number_of_users]
    row: 5
    col: 8
    width: 8
    height: 6
  - title: Retention by Platform
    name: Retention by Platform
    model: firebase
    explore: events
    type: looker_line
    fields: [events.number_of_users, events.retention_day, events.platform]
    pivots: [events.platform]
    filters:
      events.retention_day: "[0, 30]"
    sorts: [events.number_of_users desc 0, events.platform]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: still_active, label: "% still active", expression: "${events.number_of_users}/max(${events.number_of_users})",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: still_active, id: 2018-06
              - still_active, name: 2018-06}, {axisId: still_active, id: 2018-07 -
              still_active, name: 2018-07}, {axisId: still_active, id: 2018-08 - still_active,
            name: 2018-08}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: log}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1f3e5a",
        font_color: !!null '', color_application: {collection_id: 960ff0d9-39cb-4672-8b58-7d0d70c0384d,
          palette_id: fe72a87f-9ecc-4b2e-810c-874e1fda1697, options: {steps: 5, constraints: {
              min: {type: number, value: 0.25}, mid: {type: number, value: 0}, max: {
                type: percentile, value: 20}}, mirror: false, reverse: true, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [still_active]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [events.number_of_users]
    row: 5
    col: 16
    width: 8
    height: 6
  - title: Retention by Version
    name: Retention by Version
    model: firebase
    explore: events
    type: looker_line
    fields: [events.number_of_users, events.retention_day, events.version]
    pivots: [events.version]
    filters:
      events.retention_day: "[0, 30]"
      events.version: 2.6.30,2.6.31,2.62
    sorts: [events.number_of_users desc 0, events.version]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: still_active, label: "% still active", expression: "${events.number_of_users}/max(${events.number_of_users})",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: still_active, id: 2018-06
              - still_active, name: 2018-06}, {axisId: still_active, id: 2018-07 -
              still_active, name: 2018-07}, {axisId: still_active, id: 2018-08 - still_active,
            name: 2018-08}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: log}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1f3e5a",
        font_color: !!null '', color_application: {collection_id: 960ff0d9-39cb-4672-8b58-7d0d70c0384d,
          palette_id: fe72a87f-9ecc-4b2e-810c-874e1fda1697, options: {steps: 5, constraints: {
              min: {type: number, value: 0.25}, mid: {type: number, value: 0}, max: {
                type: percentile, value: 20}}, mirror: false, reverse: true, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [still_active]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [events.number_of_users]
    row: 5
    col: 0
    width: 8
    height: 6
  - title: D1 Retention
    name: D1 Retention
    model: firebase
    explore: events
    type: single_value
    fields: [events.d1_retention_rate]
    limit: 500
    column_limit: 50
    series_types: {}
    row: 3
    col: 0
    width: 8
    height: 2
  - title: D14 Retention
    name: D14 Retention
    model: firebase
    explore: events
    type: single_value
    fields: [events.d14_retention_rate]
    limit: 500
    column_limit: 50
    series_types: {}
    row: 3
    col: 8
    width: 8
    height: 2
