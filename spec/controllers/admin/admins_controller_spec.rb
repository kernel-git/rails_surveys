require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include FactoryBot::Syntax::Methods
  config.extend ControllerMacros, type: :controller
end

RSpec.describe Admin::AdminsController, type: :controller do
  describe 'GET #index' do
    context 'when logged in as administrator' do
      login_as('administrator')
      it do
        get :index, params: {}
        p response.status
        expect(response).to have_http_status(:ok)
        expect(response.status).to eq 200
        expect(response).to render_template(:index)
      end
    end
    context 'when not logged in' do
      it do
        get :index, params: {}
        p response.status
        # expect(response).to have_http_status(:unauthorized)
        # expect(response.status).to eq 401
        expect(response).to render_template(:index)
      end
    end
  end
end
