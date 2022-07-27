# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'erc-info@cklos.com'
  layout 'mailer'
end
