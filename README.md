# lab
# POST
# end point /api/v1/payments

| Attributes    | Type           |
| ------------- |:-------------:|
| credit_card_number  | string |
| expiration_month      | string      |
| expiration_year |  string      |
| card_last_numbers  | string |
| card_network      | string      |
|amount | number      |


```
curl --data "credit_card_number=5579999008551111&
             cardholder_name=Alejandra Cernas&
             expiration_year=20&
             expiration_month=08&
             amount=200&
             card_last_numbers=2000&
             card_security_code=200&
             card_security_code=111"
 http://localhost:3000/api/v1/payments
```
# Response
# status 200, created
# status 422, unprocesable entity
