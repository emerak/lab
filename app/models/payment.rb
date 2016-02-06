class Payment < Base

  attr_accessor :card_security_code,
                :credit_card_number


  field :cardholder_name, type: String
  field :bin_number, type: String
  field :expiration_date, type: String
  field :card_type, type: String
  field :card_network, type: String
  field :card_last_numbers, type: String

  #Validations
  validates_length_of :credit_card_number, minimum: 12, maximum: 12
  validates_format_of :credit_card_number, with: /\A\d\z/
  validates_presence_of :cardholder_name,
                        :expiration_date,
                        :card_security_code
end
