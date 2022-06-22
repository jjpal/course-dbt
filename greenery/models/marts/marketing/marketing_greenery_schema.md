version: 2

models:
  - name: user_order_facts
    description: contains order information at the user level
    columns: 
      - name: int_orders_count_delivered.user_guid
        description: the user guid from intermediate model
        tests:
          - unique
          - not_null
      - name: int_orders_count_delivered.order_count
        description: orders count from intermediate model
        tests:
          - unique
          - not_null
      - name: int_orders_count_delivered.time_delivery
        description: time taken for the order to be delivered from intermediate model
        tests:
          - unique
          - not_null
      - name: stg_greenery__orders.order_total
        description: total cost of the order including shipping from staging model
        tests:
          - unique
          - not_null    
      - name: stg_greenery__orders.tracking_guid
        description: the tracking number for the order/package from staging model
        tests:
          - unique
          - not_null
      - name: stg_greenery__orders.shipping_service
        description: company that was used for shipping from staging model
        tests:
          - unique
          - not_null
      - name: int_users_registered.user_registered_on
        description: time the user created the account from intermediate model
        tests:
          - unique
          - not_null
      - name: int_users_registered.user_full_name
        description: the user full name for the account from intermediate model
        tests:
          - unique
          - not_null
      - name: int_users_registered.user_account_age
        description: time from when the user created the account to the present time from intermediate model
        tests:
          - unique
          - not_null
      - name: stg_greenery__users.email as user_email
        description: the email the user entered for the account from staging model
        tests:
          - unique
          - not_null
      - name: stg_greenery__users.phone_number as user_phone_number   
        description: the user phone number entered for the account from the staging model
        tests:
          - unique
          - not_null
          