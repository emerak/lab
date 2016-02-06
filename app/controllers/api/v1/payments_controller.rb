class Api::V1::PaymentsController < Api::V1::BaseController
  def create
    payment = Payment.new(payment_params)
    if payment.save

    end
  end

  private

  def payment_params
    params.require(:payment).permit(:credit_card_number, :cardholder_name,
                                    :expiration_date, :card_security_code)
  end
end
