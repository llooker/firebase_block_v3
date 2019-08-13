## Why do you need the this block?
Firebase data in BigQuery has incredible analytical potentential, but it's not easy to query. It's not easy because:
* Every day has a new table (tables named events_YYYYMMDD). This helps keep BigQuery costs down but adds complications in queries. 
* Every _event_name_ has nested key-value pairs like _event_params.key_ and _event_params.value_ meaning that every single query will require some nasty UNNEST operation
* Same with _user_properties_ key-value pairs, all highly nested

## What does the block do for me?
* Creates a native way to select time periods and magically selected the requred data partitioned tables below
* Creates a looker dimension for every combination of _event_name_ / _event_params.key_ and _user_properties_
* Creates a great starting point to start modeling the data further to get value out of it

## How does it work?
Because every Firebase schema has some similarities but different event types and user properties, the block will generate a unique schema for your event structure. It uses a Python notebook to connect to Looker's API and query your database and output some lovely LookML. 

## How do I do use it?
### Prep Looker Side
1) Start by creating a new project by cloning this public repo: https://docs.looker.com/data-modeling/getting-started/create-projects#cloning_a_public_git_repository
2) Add your own Git repo, change the connection name and the name of the event table in _events.view.lkml_ push to production.
3) Create yourself a new API3 key https://docs.looker.com/admin-options/settings/users#api3_keys
## Run the Python Code to Generate your Model
1) 
