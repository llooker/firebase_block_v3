connection: "firebase-sample"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: events {

#   always_filter: {
#     filters: {
#       field: event_date
#       value: "last 7 days"
#     }
#   }

  join: events__event_params {
    view_label: "Event Properties"
    sql: LEFT JOIN UNNEST(events.event_params) as events__event_params ;;
    relationship: one_to_many
  }

  join: events__event_params__value {
    view_label: "Event Properties"
    sql: LEFT JOIN UNNEST([events__event_params.value]) as events__event_params__value ;;
    relationship: one_to_many
  }

  join: events__user_properties {
    sql: LEFT JOIN UNNEST(events.user_properties) as events__user_properties ;;
    view_label: "User Properties"
    relationship: one_to_many
  }

  join: events__user_properties__value {
    view_label: "User Properties"
    sql: LEFT JOIN UNNEST([events__user_properties.value]) as events__user_properties__value ;;
    relationship: one_to_many
  }

  join: sessions {
    sql_on: ${events.user_pseudo_id} = ${sessions.user_pseudo_id}
    AND ${events._event_raw} >= ${sessions.session_start_raw}
    AND ${events._event_raw} <= ${sessions.session_end_raw} ;;
    relationship: many_to_one
  }
}
