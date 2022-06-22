version: 2

models:
  - name: dim_products
    description:  
    columns: contains product inventory and last ordered items together from staging model. 
      - name: product_guid
        description: UUID for each unique product on platform
        tests:
          - unique
          - not_null
      - name: product_name
        description: Name of the product from staging model
        tests:
          - unique
          - not_null
      - name: product_price
        description: Price of the product from staging model
        tests:
          - unique
          - not_null
      - name: product_inventory
        description: Amount of inventory for product available from staging
        tests:
          - unique
          - not_null
      - name: current_ordered_items
        description: Number of units currently ordered from staging
        tests:
          - unique
          - not_null                              

- name: dim_users
    description: staging users and address models joined to include all personal user info
    columns: 
      - name: user_guid
        description: UID for each unique user from staging
        tests:
          - unique
          - not_null
      - name: first_name
        description: first name of user from staging
        tests:
          - unique
          - not_null                                                                
      - name: last_name
        description: last name of user from staging
        tests:
          - unique
          - not_null         
      - name: user_email
        description: email address of user from staging 
        tests:
          - unique
          - not_null         
      - name: user_phone_number
        description: phone number of user from staging
        tests:
          - unique
          - not_null         
      - name: last_update_activity
        description: timeframe from when user registered up to last updated activity
        tests:
          - unique
          - not_null         
      - name: user_address
        description: default delivery address for the user from staging
        tests:
          - unique
          - not_null         
      - name: user_zip_code
        description: The zipcode of the address from staging
        tests:
          - unique
          - not_null         
      - name: user_state
        description: the delivery state address for the user from staging
        tests:
          - unique
          - not_null         
      - name: user_country
        description: the delivery country address for the user from staging
        tests:
          - unique
          - not_null            

- name: fact_orders
    description: 
    columns: 
      - name: order_guid
        description: UUID for each unique order on platform from staging
        tests:
          - unique
          - not_null      
      - name: promo_guid
        description: promotional code id for the order, if any was used from staging
        tests:
          - unique
          - not_null         
      - name: user_guid
        description: UID for each unique user from staging
        tests:
          - unique
          - not_null       
      - name: order_total
        description: Total cost of the order including shipping from staging
        tests:
          - unique
          - not_null      
      - name: orders_created_at_utc
        description: timestamp the order was created from staging
        tests:
          - unique
          - not_null         
      - name: tracking_guid
        description: Tracking number for the order/package from staging
        tests:
          - unique
          - not_null       
      - name: shipping_service
        description: Company that was used for shipping from staging
        tests:
          - unique
          - not_null    
      - name: delivered_at_utc
        description: Actual timestamp of delivery from staging
        tests:
          - unique
          - not_null    
      - name: discount
        description: Absolute dollar amount that is given off with the code from staging
        tests:
          - unique
          - not_null    
      - name: promo_status
        description: The promo code that details if active or disabled from staging
        tests:
          - unique
          - not_null    
      - name: product_guid
        description: UUID for each unique product on platform from staging
        tests:
          - unique
          - not_null    
      - name: quantity 
        description: 
        tests: Number of units of the product in this order from staging
          - unique
          - not_null      
      - name: product_inventory
        description:  Amount of inventory for product available from staging
        tests:
          - unique
          - not_null   
      - name: product_price
        description: Price of the product from staging
        tests:
          - unique
          - not_null   
                                  
                                                                                
