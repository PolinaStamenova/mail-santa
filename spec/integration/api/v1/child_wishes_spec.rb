require 'swagger_helper'

RSpec.describe 'API::V1::ChildWishes', type: :request do
  path '/api/v1/child_wishes' do
    get 'Retrieves all child wishes' do
      tags 'ChildWishes'
      produces 'application/json'

      response '200', 'successful' do
        before do
          user = User.create!(email: 'test@test.com', password: 'password', name: 'Test')
          present = Present.create!(name: 'Test Present', color: 'blue', size: 'small')
          ChildWish.create!(user:, present:)
          sign_in user
        end

        schema '$ref' => '#/components/schemas/ChildWishes'

        run_test!(openapi_strict_schema_validation: true)
      end
    end
  end
end
