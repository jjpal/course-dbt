select *       
from {{ ref('fact_orders') }} 
where order_total < discount
/* 
   checking if there are any instances where discount is greater than order total 
 */