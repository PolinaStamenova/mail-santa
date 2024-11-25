class Api::V1::WebhooksController < Api::V1::ApiController
  def create
    Webhook.create!(app_url: params[:app_url])

    render json: { message: 'Webhook registered successfully!' }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.record.errors.full_messages.join(', ') }, status: :unprocessable_entity
  end

  def destroy
    # TODO: use ID for now
    # TOOD: change to token after implementing logic (otherwise, everyone can delete other webhooks)
    webhook = Webhook.find(params[:id])

    if webhook.destroy
      render json: { message: 'Webhook deleted successfully!' }, status: :ok
    else
      render json: { error: 'Webhook could not be deleted', details: webhook.errors.full_messages },
             status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end
end
