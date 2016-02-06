class Payment < Base

  attr_accessor :card_security_code,
                :credit_card_number

  MONTHS = ['01', '02', '03', '02', '05', '06', '07', '08', '09', '10', '11', '12']

  field :cardholder_name, type: String
  field :bin_number, type: String
  field :expiration_month, type: String
  field :expiration_year, type: String
  field :card_type, type: String
  field :card_network, type: String
  field :card_last_numbers, type: String
  field :amount, type: Integer
  field :status, type: String

  #Validations
  validates_length_of :credit_card_number, minimum: 13, maximum: 16
  validates_inclusion_of :expiration_month, in: MONTHS
  validates_format_of :credit_card_number, with: /\A\d\z/
  validates_presence_of :cardholder_name,
    :expiration_month,
    :expiration_year,
    :card_security_code

  private

  def bin_number=(bin_number)
    @bin_number = self.credit_card_number[0..5]
  end

end
