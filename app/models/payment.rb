class Payment < Base

  include RedisPayment

  attr_accessor :card_security_code,
                :credit_card_number,
                :encrypted_card_security_code,
                :encrypted_expiration_year,
                :encrypted_expiration_month,
                :encrypted_credit_card_number

  MONTHS = ['01', '02', '03', '02', '05', '06', '07', '08', '09', '10', '11', '12']
  CARD_NETWORKS = ['visa', 'mc', 'amex']

  field :cardholder_name, type: String
  field :bin_number, type: String
  field :expiration_month, type: String
  field :expiration_year, type: String
  field :card_type, type: String
  field :card_network, type: String
  field :card_last_numbers, type: String
  field :amount, type: Float
  field :status, type: String, default: "paid"

  #Validations
  validates_length_of :credit_card_number, minimum: 13, maximum: 16
  validates_length_of :expiration_month, minimum: 2, maximum: 2
  validates_length_of :expiration_year, minimum: 2, maximum: 2
  validates_length_of :card_security_code, minimum: 3, maximum: 3
  validates_length_of :card_last_numbers, minimum: 4, maximum: 4

  validates_inclusion_of :expiration_month, in: MONTHS
  validates_inclusion_of :card_network, in: CARD_NETWORKS

  validates_format_of :credit_card_number, with: /\A[0-9]*\z/
  validates_format_of :expiration_month, with: /\A\d{2}\z/
  validates_format_of :expiration_year, with: /\A\d{2}\z/
  validates_format_of :card_security_code, with: /\A\d{3}\z/
  validates_format_of :card_last_numbers, with: /\A\d{4}\z/

  validates_numericality_of :amount

  validates_presence_of :cardholder_name,
                        :expiration_month,
                        :expiration_year,
                        :card_security_code

  validate :expiration_date,
           :card_network_validator

  #Callbacks

  before_create :assign_bin_number
  after_create    :save_card_data

  private

  def assign_bin_number
    self.bin_number = credit_card_number[0..5]
  end

  def expiration_date
    errors.add(:expiration_year,  "Expired date")  if Time.now.strftime('%y') > expiration_year
  end

  def card_network_validator
    errors.add(:card_network, "Invalid card network") unless valid_network?
  end

  def valid_network?
    case card_network
    when 'amex'
      [34,37].include?(credit_card_number[0..1].to_i)
    when 'mc'
      [51,52,53,54,55].include?(credit_card_number[0..1].to_i)
    when 'visa'
      credit_card_number[0].to_i == 4
    end
  end

  def encrypt_card
    self.encrypted_credit_card_number = credit_card_number.encrypt(_id)
    self.encrypted_card_security_code = card_security_code.encrypt(_id)
    self.encrypted_expiration_year = expiration_year.encrypt(_id)
    self.encrypted_expiration_month = expiration_month.encrypt(_id)
  end
end
