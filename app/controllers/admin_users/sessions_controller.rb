# frozen_string_literal: true

module AdminUsers
  class SessionsController < Devise::SessionsController
    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    end

    # Login Path (if already logged in)
    def after_sign_in_path_for(_resource)
      admin_pages_dashboard_path
    end

    # Logout Path
    def after_sign_out_path_for(_resource_or_scope)
      admin_root_path
    end
  end
end
