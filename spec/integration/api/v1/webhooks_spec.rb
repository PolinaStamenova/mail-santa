require 'swagger_helper'

RSpec.describe 'Webhooks API', type: :request do
  path '/api/v1/webhooks' do
    post 'Creates a webhook' do
      tags 'Webhooks'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :webhook, in: :body, schema: {
        '$ref' => '#/components/schemas/CreateWebhook'
      }

      response '201', 'Webhook successfully created' do
        let(:webhook) { { url: 'https://example.com/webhook' } }

        schema '$ref': '#/components/schemas/ResponseWebhook'

        run_test!(openapi_strict_schema_validation: true) do |response|
          expect(response.status).to eq(201)
          expect(response.body).to include('Webhook registered successfully!')
        end
      end

      response '422', 'Invalid request' do
        let(:webhook) { { url: '' } }

        schema '$ref': '#/components/schemas/ErrorResponse'

        run_test!(openapi_strict_schema_validation: true) do |response|
          expect(response.status).to eq(422)
          expect(response.body).to include('Url is invalid')
        end
      end
    end
  end

  path '/api/v1/webhooks/{id}' do # rubocop:disable Metrics/BlockLength
    delete 'Deletes a webhook' do # rubocop:disable Metrics/BlockLength
      tags 'Webhooks'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :string, description: 'ID of the webhook to delete'

      let!(:webhook) { Webhook.create!(url: 'https://example.com') }

      response '200', 'Webhook deleted successfully' do
        let(:id) { webhook.id }

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(response.body).to include('Webhook deleted successfully!')
          expect(Webhook.exists?(webhook.id)).to eq(false)
        end
      end

      response '422', 'Webhook could not be deleted' do
        let(:id) { webhook.id }

        before do
          allow_any_instance_of(Webhook).to receive(:destroy).and_return(false)
        end

        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to include('Webhook could not be deleted')
          expect(Webhook.exists?(webhook.id)).to eq(true)
        end
      end

      response '404', 'No Webhook found with this ID' do
        let(:id) { 'someid123' }

        run_test! do |response|
          expect(response).to have_http_status(:not_found)
          expect(response.body).to include(`Couldn't find Webhook with 'id'=someid123`)
          expect(Webhook.exists?(webhook.id)).to eq(true)
        end
      end
    end
  end
end
