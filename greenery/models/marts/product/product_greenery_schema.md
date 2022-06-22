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
   	  

 


 

