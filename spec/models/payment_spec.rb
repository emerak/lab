require 'rails_helper'

describe Payment do

  it "is not valid if credit_card_number is shorter than 13 numbers" do
    payment =  build(:payment, credit_card_number: 12345678901)
    expect(payment).to have_at_least(1).error_on(:credit_card_number)
    expect(payment.errors_on(:credit_card_number)).to include("is too short (minimum is 13 characters)")
  end

  it "is not valid if credit_card_number is longer than 16 numbers" do
    payment =  build(:payment, credit_card_number: 100234567890100000)
    expect(payment).to have_at_least(1).error_on(:credit_card_number)
    expect(payment.errors_on(:credit_card_number)).to include("is too long (maximum is 16 characters)")
  end

  it "is not valid if credit_card_number has characters" do
    payment =  build(:payment, credit_card_number: 'qoilkjlrtyuiopas')
    expect(payment).to have_at_least(1).error_on(:credit_card_number)
    expect(payment.errors_on(:credit_card_number)).to include("is invalid")
  end

  it "is not valid if  expiration_month has characters" do
    payment =  build(:payment, credit_card_number: 12345678912394, expiration_month: 'qwertyuiopas')
    payment.save
    expect(payment.errors).to have_at_least(1).error_on(:expiration_month)
    expect(payment.errors_on(:expiration_month)).to include("is not included in the list")
  end
end
