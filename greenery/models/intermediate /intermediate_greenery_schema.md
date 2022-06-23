version: 2

models:
  - name: int_address_state_count
    description: 
    columns: 
      - name: 
        description: 
        tests:
          - unique
          - not_null
     - name: 
        description: 
        tests:
          - unique
          - not_null

- name: int_order_items_product_agg
    description: 
    columns: 
      - name: 
        description: 
        tests:
          - unique
          - not_null      
      - name: 
        description: 
        tests:
          - unique
          - not_null                                                     

- name: int_orders_count_delivered
    description: 
    columns: 
      - name: 
        description: 
        tests:
          - unique
          - not_null  
      - name: 
        description: 
        tests:
          - unique
          - not_null                     

- name: int_users_registered
    description: 
    columns: 
      - name: 
        description: 
        tests:
          - unique
          - not_null     
      - name: 
        description: 
        tests:
          - unique
          - not_null                                                          