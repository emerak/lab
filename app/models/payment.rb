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
  field :status, type: String

  #Validations
  validates_length_of :credit_card_number, minimum: 13, maximum: 16
  validates_length_of :expiration_month, minimum: 2, maximum: 2
  validates_length_of :expiration_year, minimum: 2, maximum: 2

  validates_inclusion_of :expiration_month, in: MONTHS

  validates_format_of :credit_card_number, with: /\A[0-9]*\z/
  validates_format_of :expiration_month, with: /\A\d{2}\z/
  validates_format_of :expiration_year, with: /\A\d{2}\z/

  validates_presence_of :cardholder_name,
                        :expiration_month,
                        :expiration_year,
                        :card_security_code

  validate :expiration_date

  private

  def bin_number=(bin_number)
    @bin_number = self.credit_card_number[0..5]
  end

  def expiration_date
    errors.add(:expiration_year,  "Expired date")  if Time.now.strftime('%y') > expiration_year
  end

end
