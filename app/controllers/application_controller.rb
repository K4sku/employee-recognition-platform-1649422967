# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_any!

  rescue_from 'AuthorizationError', with: :deny_access

  private

  def deny_access
    redirect_to root_path, flash: { alert: 'Only givers can modify kudos' }
  end
end

def authenticate_any!
  if admin_user_signed_in?
    true
  else
    authenticate_employee!
  end
end
