include: "user_properties_generated*"
include: "events_generated*"

view: events {
  sql_table_name: `firebase-public-project.analytics_153293282.events_*`  ;;

    extends: [events_generated,user_properties_generated]

    dimension: app_info {
      hidden: yes
      sql: ${TABLE}.app_info ;;
    }

    dimension: device {
      hidden: yes
      sql: ${TABLE}.device ;;
    }

    dimension: event_bundle_sequence_id {
      type: number
      sql: ${TABLE}.event_bundle_sequence_id ;;
    }

    dimension_group: event {
      type: time
      timeframes: [date, week, day_of_week, month, year]
      sql: TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d\d\d\d\d\d\d\d'))) ;;
    }

    dimension_group: _event {
      label: "Event"
      timeframes: [raw,time,hour,minute]
      type: time
      sql: TIMESTAMP_MICROS(${TABLE}.event_timestamp) ;;
    }

    dimension: event_dimensions {
      hidden: yes
      sql: ${TABLE}.event_dimensions ;;
    }

    dimension: event_name {
      type: string
      sql: ${TABLE}.event_name ;;
    }

    dimension: screen.origin {
      type: string
      sql:
      CASE WHEN ${event_name} = 'screen' THEN
        (SELECT value.string_value
        FROM UNNEST(${event_params})
        WHERE key = 'origin')
      END ;;
    }

    dimension: event_params {
      hidden: yes
      sql: ${TABLE}.event_params ;;
    }

    dimension: event_previous_timestamp {
      type: number
      sql: ${TABLE}.event_previous_timestamp ;;
    }

    dimension: event_server_timestamp_offset {
      type: number
      sql: ${TABLE}.event_server_timestamp_offset ;;
    }

    dimension: event_value_in_usd {
      type: number
      sql: ${TABLE}.event_value_in_usd ;;
    }

    dimension: geo {
      hidden: yes
      sql: ${TABLE}.geo ;;
    }

    dimension: platform {
      type: string
      sql: ${TABLE}.platform ;;
    }

    dimension: stream_id {
      hidden: yes
      type: string
      sql: ${TABLE}.stream_id ;;
    }

    dimension: traffic_source {
      hidden: yes
      sql: ${TABLE}.traffic_source ;;
    }

    dimension: user_first_touch_timestamp {
      type: number
      sql: ${TABLE}.user_first_touch_timestamp ;;
    }

    dimension: user_id {
      description: "The user ID set via the setUserId API."
      type: string
      sql: ${TABLE}.user_id ;;
    }

    dimension: user_ltv {
      hidden: yes
      sql: ${TABLE}.user_ltv ;;
    }

    dimension: user_properties {
      hidden: yes
      sql: ${TABLE}.user_properties ;;
    }

    dimension: user_pseudo_id {
      description: "The pseudonymous id (e.g., app instance ID) for the user."
      type: string
      sql: ${TABLE}.user_pseudo_id ;;
    }

    measure: number_of_users {
      type: count_distinct
      sql: COALESCE(${user_pseudo_id},${user_id}) ;;
    }

    measure: number_of_events {
      type: count
      drill_fields: [event_name]
    }
  }

  view: events__user_properties__value {
    dimension: double_value {
      type: number
      sql: ${TABLE}.double_value ;;
    }

    dimension: float_value {
      type: number
      sql: ${TABLE}.float_value ;;
    }

    dimension: int_value {
      type: number
      sql: ${TABLE}.int_value ;;
    }

    dimension: set_timestamp_micros {
      type: number
      sql: ${TABLE}.set_timestamp_micros ;;
    }

    dimension: string_value {
      type: string
      sql: ${TABLE}.string_value ;;
    }

    dimension: type{
      sql: CASE
        WHEN ${string_value} is not null then 'string'
        WHEN COALESCE(${int_value},${float_value},${double_value}) is not null then 'number'
        WHEN ${set_timestamp_micros} is not null then 'timestamp'
        ELSE 'string'
        END;;
    }
  }

  view: events__user_properties {
    dimension: key {
      type: string
      sql: ${TABLE}.key ;;
    }

    dimension: value {
      hidden: yes
      sql: ${TABLE}.value ;;
    }
  }

  view: events__traffic_source {
    dimension: medium {
      type: string
      sql: ${TABLE}.medium ;;
    }

    dimension: name {
      type: string
      sql: ${TABLE}.name ;;
    }

    dimension: source {
      type: string
      sql: ${TABLE}.source ;;
    }
  }

  view: events__event_params__value {
    dimension: double_value {
      type: number
      sql: ${TABLE}.double_value ;;
    }

    dimension: float_value {
      type: number
      sql: ${TABLE}.float_value ;;
    }

    dimension: int_value {
      type: number
      sql: ${TABLE}.int_value ;;
    }

    dimension: string_value {
      type: string
      sql: ${TABLE}.string_value ;;
    }

    dimension: type{
      sql: CASE
        WHEN ${string_value} is not null then 'string'
        WHEN COALESCE(${int_value},${float_value},${double_value}) is not null then 'number'
        ELSE 'string'
        END;;
    }
  }

  view: events__event_params {
    dimension: key {
      type: string
      sql: ${TABLE}.key ;;
    }

    dimension: value {
      hidden: yes
      sql: ${TABLE}.value ;;
    }
  }

  view: events__geo {
    dimension: city {
      type: string
      sql: ${TABLE}.city ;;
    }

    dimension: continent {
      type: string
      sql: ${TABLE}.continent ;;
    }

    dimension: country {
      type: string
      map_layer_name: countries
      sql: ${TABLE}.country ;;
    }

    dimension: metro {
      type: string
      sql: ${TABLE}.metro ;;
    }

    dimension: region {
      type: string
      sql: ${TABLE}.region ;;
    }

    dimension: sub_continent {
      type: string
      sql: ${TABLE}.sub_continent ;;
    }
  }

  view: events__user_ltv {
    dimension: currency {
      type: string
      sql: ${TABLE}.currency ;;
    }

    dimension: revenue {
      type: number
      sql: ${TABLE}.revenue ;;
    }
  }

  view: events__app_info {
    dimension: id {
      primary_key: yes
      type: string
      sql: ${TABLE}.id ;;
    }

    dimension: firebase_app_id {
      type: string
      sql: ${TABLE}.firebase_app_id ;;
    }

    dimension: install_source {
      type: string
      sql: ${TABLE}.install_source ;;
    }

    dimension: install_store {
      type: string
      sql: ${TABLE}.install_store ;;
    }

    dimension: version {
      type: string
      sql: ${TABLE}.version ;;
    }
  }

  view: events__device {
    dimension: advertising_id {
      type: string
      sql: ${TABLE}.advertising_id ;;
    }

    dimension: browser {
      type: string
      sql: ${TABLE}.browser ;;
    }

    dimension: browser_version {
      type: string
      sql: ${TABLE}.browser_version ;;
    }

    dimension: category {
      type: string
      sql: ${TABLE}.category ;;
    }

    dimension: is_limited_ad_tracking {
      type: string
      sql: ${TABLE}.is_limited_ad_tracking ;;
    }

    dimension: language {
      type: string
      sql: ${TABLE}.language ;;
    }

    dimension: mobile_brand_name {
      type: string
      sql: ${TABLE}.mobile_brand_name ;;
    }

    dimension: mobile_marketing_name {
      type: string
      sql: ${TABLE}.mobile_marketing_name ;;
    }

    dimension: mobile_model_name {
      type: string
      sql: ${TABLE}.mobile_model_name ;;
    }

    dimension: mobile_os_hardware_model {
      type: string
      sql: ${TABLE}.mobile_os_hardware_model ;;
    }

    dimension: operating_system {
      type: string
      sql: ${TABLE}.operating_system ;;
    }

    dimension: operating_system_version {
      type: string
      sql: ${TABLE}.operating_system_version ;;
    }

    dimension: time_zone_offset_seconds {
      type: number
      sql: ${TABLE}.time_zone_offset_seconds ;;
    }

    dimension: vendor_id {
      type: string
      sql: ${TABLE}.vendor_id ;;
    }

    dimension: web_info {
      hidden: yes
      sql: ${TABLE}.web_info ;;
    }
  }

  view: events__device__web_info {
    dimension: browser {
      type: string
      sql: ${TABLE}.browser ;;
    }

    dimension: browser_version {
      type: string
      sql: ${TABLE}.browser_version ;;
    }

    dimension: hostname {
      type: string
      sql: ${TABLE}.hostname ;;
    }
  }

  view: events__event_dimensions {
    dimension: hostname {
      type: string
      sql: ${TABLE}.hostname ;;
    }
  }
