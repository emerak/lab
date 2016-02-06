require 'rails_helper'

describe Payment do

  it "is not valid if credit_card_number is shorter than 12 numbers" do
    payment =  build(:payment, credit_card_number: 12345678901)
    expect(payment).to have_at_least(1).error_on(:credit_card_number)
    expect(payment.errors_on(:credit_card_number)).to include("is too short (minimum is 12 characters)")
  end

  it "is not valid if credit_card_number is longer than 12 numbers" do
    payment =  build(:payment, credit_card_number: 1002345678901)
    expect(payment).to have_at_least(1).error_on(:credit_card_number)
    expect(payment.errors_on(:credit_card_number)).to include("is too long (maximum is 12 characters)")
  end

  it "is not valid if credit_card_number has characters besides numbers" do
    payment =  build(:payment, credit_card_number: 'qwertyuiopas')
    expect(payment).to have_at_least(1).error_on(:credit_card_number)
    expect(payment.errors_on(:credit_card_number)).to include("is invalid")
  end
end
