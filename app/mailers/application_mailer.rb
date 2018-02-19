# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'support@moonhythe.com'
  layout 'mailer'
end
