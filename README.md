## Why do you need the this block?
Firebase data in BigQuery has incredible analytical potentential, but it's not easy to query. It's not easy because:

* Every day has a new table (tables named events_YYYYMMDD). This helps keep BigQuery costs down but adds complications in queries.
* Every _event_name_ has nested key-value pairs like _event_params.key_ and _event_params.value_ meaning that every single query will require some complex UNNEST operation
* Same with _user_properties_ key-value pairs, all highly nested

## What does the block do for you?

* Creates a native way to select time periods and magically selected the requred data partitioned tables below
* Adds sessionization (which is missing from Firebase data)
* Adds retention cohort analysis capabilities
* Creates a looker dimension for every combination of _event_name_ / _event_params.key_ and _user_properties_
* Creates a great starting point to start modeling the data further to get value out of it

## How does it work?
Because every Firebase schema has some similarities but different event types and user properties, the block will generate a unique schema for your event structure. It uses a Python notebook to connect to Looker's API and query your database and output some lovely LookML.

## How do you do use it?

### Prep Looker Side

1. Start by creating a new project by cloning this public repo: https://docs.looker.com/data-modeling/getting-started/create-projects#cloning_a_public_git_repository
2. Add your own Git repo, change the connection name and the name of the event table in _events.view.lkml_ and the datagroup for _sessions.view.lkml_ and push to production.
3. Create yourself a new API3 key https://docs.looker.com/admin-options/settings/users#api3_keys

## Run the Python Code to Generate your Model

1. Download the Firebase Python Notebook and open it with your favorite Notebook runner. I use Google Colab https://github.com/llooker/firebase_block_v3/blob/master/Firebase_Block_v3.ipynb
2. Enter your _base_url_ _client_id_ and _client_secret_  (this is your API3 key)
3. Run the Python notebook
4. Copy the results of the _event_properties_ section into _events_generated.view.lkml_ (replace the entire file)
5. Copy the results of the _user_properties_ section into _user_properties_generated.view.lkml_ (replace the entire file)
6. World domination.

## Troubleshooting

* If you have duplicate dimensions with the same name (firebase allows same event name , keys but different types)
Change the part of events “Event Properties” python code  like this:
 `print("dimension: "+event_name+"."+key+ "_" + type[0]+" {")`(thanks @nishimix for the fix!)
