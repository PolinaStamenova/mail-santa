class ChangeAppUrlToNotNullInWebhooks < ActiveRecord::Migration[7.0]
  def change
    change_column_null :webhooks, :app_url, false
  end
end
