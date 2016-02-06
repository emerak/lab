class Api::V1::PaymentsController < Api::V1::BaseController
  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      respond_with @payment, status: :created
    else
      respond_with @payment, status: :unprocessable_entity
    end

  end
  private

  def payment_params
    params.permit(:credit_card_number, :cardholder_name,
                  :expiration_year, :card_security_code,
                  :amount, :expiration_month, :card_last_numbers,
                  :card_network)
  end
end
