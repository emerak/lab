class ExternalResourcesController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def payment
    @resource = Resource.new(resource_params)
    if @resource.save
      respond_with @resource, status: :created, location: external_resources_payment_url(@resource)
    else
      respond_with :api, :v1, @resource, status: :unprocessable_entity, location: external_resources_payment_url(@resource)
    end
  end

  private

  def resource_params
    params.permit(:credit_card_number, :cardholder_name,
                  :expiration_year, :card_security_code,
                  :amount, :expiration_month, :card_last_numbers,
                  :card_network)
  end
end
