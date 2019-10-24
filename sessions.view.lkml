view: sessions {
  ##Notes:
  # Session pattern from https://stackoverflow.com/a/55116882/1108832
  # If you're using user_id instead of user_pseudo_id you should replace it!

  derived_table: {
    #datagroup_trigger:
    sql: SELECT unique_session_id,
       user_session_id,
       user_pseudo_id,
       MAX(TIMESTAMP_MICROS(event_timestamp)) as session_end,
       MIN(TIMESTAMP_MICROS(event_timestamp)) as session_start,
       (MAX(event_timestamp) - MIN(event_timestamp))/(60 * 1000 * 1000) AS session_length_minutes
  FROM (
SELECT user_pseudo_id,
       event_timestamp,
       SUM(is_new_session) OVER (ORDER BY user_pseudo_id, event_timestamp) AS unique_session_id,
       SUM(is_new_session) OVER (PARTITION BY user_pseudo_id ORDER BY event_timestamp) AS user_session_id
  FROM (
       SELECT *,
              CASE WHEN TIMESTAMP_DIFF(TIMESTAMP_MICROS(event_timestamp), TIMESTAMP_MICROS(last_event),MINUTE) >= 20 --session timout = 20 minutes
                     OR last_event IS NULL
                   THEN 1 ELSE 0 END AS is_new_session
         FROM (
              SELECT user_pseudo_id,
                     event_timestamp,
                     LAG(event_timestamp,1) OVER (PARTITION BY user_pseudo_id ORDER BY event_timestamp) AS last_event
                 FROM ${events.SQL_TABLE_NAME}
              ) last
       ) final
       ) session
 GROUP BY 1,2,3
 ;;
  }

  dimension: unique_session_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.unique_session_id ;;
  }

  dimension: user_session_id {
    description: "Is this the first, second, etc session for the user"
    type: number
    sql: ${TABLE}.user_session_id ;;
  }

  dimension: user_pseudo_id {
    type: string
    sql: ${TABLE}.user_pseudo_id ;;
  }

  dimension_group: session_end {
    type: time
    sql: ${TABLE}.session_end ;;
  }

  dimension_group: session_start {
    type: time
    sql: ${TABLE}.session_start ;;
  }

  dimension: session_length_minutes {
    type: number
    sql: ${TABLE}.session_length_minutes ;;
    value_format_name: decimal_2
  }

  measure: number_of_sessions {
    type: count
    drill_fields: [detail*]
  }

  measure: average_session_length {
    description: "(minutes)"
    type: average
    sql: ${session_length_minutes} ;;
    value_format_name: decimal_2
  }

  measure: average_first_session_length {
    description: "(minutes)"
    type: average
    sql: ${session_length_minutes} ;;
    filters: {
      field: user_session_id
      value: "1"
    }
    value_format_name: decimal_2
  }

  set: detail {
    fields: [
      unique_session_id,
      user_session_id,
      user_pseudo_id,
      session_end_time,
      session_start_time,
      session_length_minutes
    ]
  }
}
