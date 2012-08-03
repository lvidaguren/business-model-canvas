Recaptcha.configure do |config|
  config.public_key  = Rails.env == 'production' ? '6Lck49QSAAAAAMhHXoKnwADpOxjdSOcctsMVQNBG' : '6LcO49QSAAAAANe4VzO5gG_zljGx3n94y9drUl1E'
  config.private_key = Rails.env == 'production' ? '6Lck49QSAAAAAIq-k-Ro5XzyyAKK--_tywXvSuZ5' : '6LcO49QSAAAAALEOZEK_rWF6xVxcajDM3yM1Z8_0'
end