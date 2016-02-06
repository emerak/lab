# lab
# POST
# end point /api/v1/payments
  field :type: String
  field :bin_number, type: String
  field :expiration_month, type: String
  field :expiration_year, type: String
  field :card_type, type: String
  field :card_network, type: String
  field :card_last_numbers, type: String
  field :amount, type: Float
  field :status, type: String, default: "paid"

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
