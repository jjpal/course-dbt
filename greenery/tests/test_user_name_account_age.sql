select *       
from {{ ref('int_user_registered') }} 
where (user_full_name is null) and (user_account_age is null)