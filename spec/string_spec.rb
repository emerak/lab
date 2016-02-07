require 'rails_helper'

describe String do
  it "decrypts string successfully" do
    word =  Faker::Lorem.word
    encrypted_word = word.encrypt("key")
    expect(encrypted_word).not_to eql word
    expect(encrypted_word.decrypt("key")).to eql word
  end
end
