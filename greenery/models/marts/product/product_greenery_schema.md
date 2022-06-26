version: 2

models:
  - name: fact_page_views
    description: contains all page view events from greenery
    columns: 
      - name: event_guid 
        description: UUID of each unique event on the platform
        tests:
          - unique
          - not_null
      - name: user_guid
        description: UUID of the user that this event is associated with
        tests:
          - unique
          - not_null
      - name: event_type
        description: Type of event (add_to_cart, checkout, page_view, package_shipped) in order workflow
        tests:
          - unique
          - not_null	       		

- name: fact_user_sessions_product
    description: contains all page view events from greenery
    columns: 
      - name: product_guid 
        description: UUID of each unique product 
        tests:
          - unique
          - not_null
      - name: product_name
        description: name of product
        tests:
          - unique
          - not_null
      - name: conversion_rate_by_product
        description: summation of addtocart events / unique count of event sessions
        tests:
          - unique
          - not_null	     
   	  

 


 

