# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  tls:                         true,
  address:                     'smtp.gmail.com',
  port:                        '465',
  user_name:                   'moonhythe@gmail.com',
  password:                    'krisnikola2016',
  domain:                      'moonhythe.com',
  authentication:              'plain',
  enable_starttls_auto:        true
}
