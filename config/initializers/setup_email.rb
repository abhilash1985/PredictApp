ActionMailer::Base.smtp_settings = {
  authentication: :plain,
  user_name: 'cricketfever2015@gmail.com',
  password: '123qweAadmin',
  address: 'smtp.gmail.com',
  port: 587,
  domain: 'gmail.com',
  enable_starttls_auto: true
}
