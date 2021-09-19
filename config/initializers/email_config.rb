# frozen_string_literal: true

ActionMailer::Base.delivery_method = :smtp # :letter_opener # :smtp
ActionMailer::Base.raise_delivery_errors = false

ActionMailer::Base.smtp_settings = {
  authentication: :plain,
  user_name: Rails.application.credentials.mail[:user_name],
  password: Rails.application.credentials.mail[:password],
  address: Rails.application.credentials.mail[:address],
  port: Rails.application.credentials.mail[:port],
  domain: Rails.application.credentials.mail[:domain],
  enable_starttls_auto: true
}

LetterOpener.configure do |config|
  # To overrider the location for message storage.
  # Default value is `tmp/letter_opener`
  # config.location = Rails.root.join('tmp', 'my_mails')

  # To render only the message body, without any metadata or extra containers or styling.
  # Default value is `:default` that renders styled message with showing useful metadata.
  config.message_template = :light
end

ActionMailer::Base.default_url_options = { host: Rails.application.credentials.mail[:host] }
