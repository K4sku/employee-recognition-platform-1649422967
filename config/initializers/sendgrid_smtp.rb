ActionMailer::Base.smtp_settings = {
  domain:         'cklos.com',
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain,
  user_name:      'apikey',
  enable_starttls_auto: true,
  password:       Rails.application.credentials.sendgrid[:api_key]
}
