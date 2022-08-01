# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'erp-info@cklos.com'
  layout 'mailer'
end
