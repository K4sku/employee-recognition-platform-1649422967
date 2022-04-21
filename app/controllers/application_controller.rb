# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from 'AuthorizationError', with: :deny_access

  private

  def deny_access
    redirect_to root_path, flash: { alert: 'Only givers can modify kudos' }
  end
end
