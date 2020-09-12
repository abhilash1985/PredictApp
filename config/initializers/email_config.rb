ActionMailer::Base.smtp_settings = {
  authentication: :plain,
  user_name: Rails.application.credentials.mail[:user_name],
  password: Rails.application.credentials.mail[:password],
  address: 'smtp.gmail.com',
  port: 587,
  domain: 'gmail.com',
  enable_starttls_auto: true
}

ActionMailer::Base.default_url_options = { host: 'www.prediktnwin.com' }
