# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You can not perform this action.'
    can_be_infinite_redirect = request.url == request.referer
    if can_be_infinite_redirect
      redirect_to root_path
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
