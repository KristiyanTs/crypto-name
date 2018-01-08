# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  port: '587',
  authentication: :plain,
  user_name: 'omnimenu2016@gmail.com',
  password: 'krisnikola2016',
  domain: 'moonhythe.com',
  enable_starttls_auto: true
}
