require 'rails_helper'

describe Payment do

  it "is not valid if credit_card_number is shorter than 13 numbers" do
    payment =  build(:payment, credit_card_number: '12345678901')
    expect(payment).to have_at_least(1).error_on(:credit_card_number)
    expect(payment.errors_on(:credit_card_number)).to include("is too short (minimum is 13 characters)")
  end

  it "is not valid if credit_card_number is longer than 16 numbers" do
    payment =  build(:payment, credit_card_number: '100234567890100000')
    expect(payment).to have_at_least(1).error_on(:credit_card_number)
    expect(payment.errors_on(:credit_card_number)).to include("is too long (maximum is 16 characters)")
  end

  it "is not valid if credit_card_number has letters" do
    payment =  build(:payment, credit_card_number: 'qoilkjlrtyuiopas')
    expect(payment).to have_at_least(1).error_on(:credit_card_number)
    expect(payment.errors_on(:credit_card_number)).to include("is invalid")
  end

  it "is not valid if  expiration_month has letters" do
    payment =  build(:payment, credit_card_number: '12345678912394', expiration_month: 'qwertyuiopas')
    payment.save
    expect(payment.errors).to have_at_least(1).error_on(:expiration_month)
    expect(payment.errors_on(:expiration_month)).to include("is not included in the list")
  end

  it "is not valid if  expiration_year has 4 length format" do
    payment =  build(:payment, credit_card_number: '12345678912394', expiration_year: 2001)
    payment.save
    expect(payment.errors).to have_at_least(1).error_on(:expiration_year)
    expect(payment.errors_on(:expiration_year)).to include("is too long (maximum is 2 characters)")
  end

  it "is not valid if  expiration_year has letters" do
    payment =  build(:payment, credit_card_number: '12345678912394', expiration_year: '1x')
    payment.save
    expect(payment.errors).to have_at_least(1).error_on(:expiration_year)
    expect(payment.errors_on(:expiration_year)).to include("is invalid")
  end

  it "is not valid if  expiration_year is minor than current year" do
    payment =  build(:payment, credit_card_number: '12345678912394', expiration_year: '15')
    payment.save
    expect(payment.errors).to have_at_least(1).error_on(:expiration_year)
    expect(payment.errors_on(:expiration_year)).to include("Expired date")
  end

  it "assings bin number with first 6 card digits" do
    payment =  build(:payment, credit_card_number: '42345678912394', expiration_year: '16')
    bin_number = "423456"
    payment.save
    expect(payment.bin_number).to eql bin_number
  end

  it "is paid if saved successfully" do
    payment =  build(:payment, credit_card_number: '12345678912394', expiration_year: '16')
    payment.save
    expect(payment.status).to eql "paid"
  end

  it "is valid when amount is a number" do
    payment =  build(:payment, credit_card_number: '12345678912394', expiration_year: '16', amount: 100)
    payment.save
    expect(payment.amount).to eql 100.0
  end

  it "is invalid if network does not match with credit card number" do
    payment =  build(:payment, card_network: "visa", credit_card_number: '12345678912394', expiration_year: '16', amount: 100)
    payment.save
    expect(payment.errors).to have_at_least(1).error_on(:card_network)
    expect(payment.errors_on(:card_network)).to include("Invalid card network")
  end
end
