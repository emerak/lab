class Api::V1::PaymentsController < Api::V1::BaseController
  require 'net/http'


  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      uri = URI('http://localhost:3001/external_resources/payment')
      res = Net::HTTP.post_form(uri, credit_card_number: @payment.card_number, cardholder_name: @payment.cardholder_name,
                                expiration_year:  @payment.expiration_year, card_security_code: @payment.security_code,
                                amount: @payment.amount, expiration_month: @payment.expiration_month, card_network: @payment.card_network,
                                card_last_numbers: @payment.card_last_numbers)

      if res.is_a?(Net::HTTPSuccess)
        @payment.status = 'paid'
        @payment.save
        respond_with @payment, status: :created, location: api_v1_payments_url(@payment)
      else
        @payment.status = 'rejected'
        @payment.save
        respond_with :api, :v1, @payment, status: :unprocessable_entity, location: api_v1_payments_url(@payment)
      end
    else
        respond_with :api, :v1, @payment, status: :unprocessable_entity, location: api_v1_payments_url(@payment)
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
