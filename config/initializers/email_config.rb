ActionMailer::Base.smtp_settings = {
  authentication: :plain,
  user_name: Rails.application.credentials.mail[:user_name],
  password: Rails.application.credentials.mail[:password],
  address: Rails.application.credentials.mail[:address],
  port: Rails.application.credentials.mail[:port],
  domain: Rails.application.credentials.mail[:domain],
  enable_starttls_auto: true
}

ActionMailer::Base.default_url_options = { host: Rails.application.credentials.mail[:host] }
