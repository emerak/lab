module RedisPayment
  extend ActiveSupport::Concern

  def save_card_data
    encrypt_card
    save_card_data
  end

  private

  def save_redis_data
    transaction = $redis.hmset("payments:#{_id}",
                               'credit_card_number', encrypted_credit_card_number,
                               'csc', encrypted_card_security_code,
                               'expiration_month', encrypted_expiration_month,
                               'expiration_year', encrypted_expiration_year)

    return if transaction

    update(status: 'failed')
    errors.add(:redis, "Redis can't save data")
  end

end
