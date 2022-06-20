select *    
from {{ ref('stg_greenery__products' )}}
product_price <= 0