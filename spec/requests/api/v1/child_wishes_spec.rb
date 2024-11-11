require 'rails_helper'

RSpec.describe 'Api::V1::ChildWishes', type: :request do
  describe 'GET /index' do
    let(:user) { User.create!(email: 'test@test.com', password: 'password', name: 'Test') }

    before { sign_in user }

    it 'returns a successful response' do
      get api_v1_child_wishes_path

      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of child wishes' do
      present = Present.create!(name: 'Test', color: 'blue', size: 'small')
      child_wish = ChildWish.create!(user:, present:)

      get api_v1_child_wishes_path

      expect(response.body).to include(child_wish.present.name)
    end
  end
end
