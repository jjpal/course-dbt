version: 2

models:
  - name: int_address_state_count_orders 
    description: Contains state counts and order totals by state
    columns: 
      - name: state
        description: users state address
        tests:
          - unique
          - not_null
     - name: order_count
        description: order count grouped by state
        tests:
          - unique
          - not_null
      - name: order_totals
        description: order totals by state
        tests:
          - unique
          - not_null         

- name: int_order_items_product_agg
    description: Contains order item aggregated products
    columns: 
      - name: product_guid 
        description: Unique product UUID
        tests:
          - unique
          - not_null      
      - name: product_ordered
        description: aggregated quantity of products ordered
        tests:
          - unique
          - not_null                                                     

- name: int_orders_count_delivered
    description: Contains orders aggregated and time for delivery
    columns: 
      - name: user_guid
        description: Unique user UUID
        tests:
          - unique
          - not_null  
      - name: order_count
        description: aggregated order count
        tests:
          - unique
          - not_null  
      - name: time_delivery
        description: time for shipped orders to be deliver
        tests:
          - unique
          - not_null                       

- name: int_session_events_agg
    description: Contains event sessions aggregation
    columns: 
      - name: session_guid  
        description: Unique session UUID
        tests:
          - unique
          - not_null     
      - name:  events_created_at_utc
        description: Timestamp of the event
        tests:
          - unique
          - not_null
   - name: user_guid    
        description: Unique user UUID
        tests:
          - unique
          - not_null     
      - name: page_views
        description: aggreated page view event type
        tests:
          - unique
          - not_null
   - name: add_to_carts
        description: aggreated add to cart event type
        tests:
          - unique
          - not_null     
      - name: check_outs
        description: aggreated checkout event type
        tests:
          - unique
          - not_null                          
    - name: package_ships
        description: aggreated package shipped event type
        tests:
          - unique
          - not_null    

- name: int_user_sessions_product_agg
    description: Contains session aggregation for users
    columns: 
     - name: user_guid
        description: Unique user UUID
        tests:
          - unique
          - not_null     
      - name: session_guid
        description: Unique seesion UUID
        tests:
          - unique
          - not_null  
      - name: product_guid
        description: Unique product UUID
        tests:
          - unique
          - not_null                     
      - name: page_view
        description: aggreated page_view event type
        tests:
          - unique
          - not_null     
      - name: add_to_cart
        description: aggreated add_to_cart event type
        tests:
          - unique
          - not_null           
      - name: check_out
        description: aggreated checkout event type
        tests:
          - unique
          - not_null     
      - name: package_shipped
        description: aggreated package shipped event type
        tests:
          - unique
          - not_null  

- name: int_users_registerd
    description: Contains user registration timestamp, fullname and how long account has been open
    columns: 
      - name: user_guid
        description: Unique user UUID
        tests:
          - unique
          - not_null     
      - name: user_registered_on
        description: time when the user created the account
        tests:
          - unique
          - not_null
      - name: user_full_name
        description: fullname for user
        tests:
          - unique
          - not_null   
      - name: user_account_age  
        description: time from when user created account up to current time
        tests:
          - unique
          - not_null                                             


       
       
               