# frozen_string_literal: true

# ActionMailer::Base.delivery_method = :letter_opener # :smtp
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = { address: '127.0.0.1', port: 1025 }
ActionMailer::Base.raise_delivery_errors = false

# ActionMailer::Base.smtp_settings = {
#   authentication: :plain,
#   user_name: Rails.application.credentials.mail_config[:user_name],
#   password: Rails.application.credentials.mail_config[:password],
#   address: Rails.application.credentials.mail_config[:address],
#   port: Rails.application.credentials.mail_config[:port],
#   domain: Rails.application.credentials.mail_config[:domain],
#   enable_starttls_auto: true
# }

ActionMailer::Base.default_url_options = { host: Rails.application.credentials.mail[:host] }
