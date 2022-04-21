require 'rails_helper'

RSpec.describe "Admin::Pages", type: :request do
  describe "GET /dashboard" do
    it "returns http success" do
      get "/admin/pages/dashboard"
      expect(response).to have_http_status(:success)
    end
  end

end
