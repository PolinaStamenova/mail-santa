class CreateWebhooks < ActiveRecord::Migration[7.0]
  def change
    create_table :webhooks, id: :uuid do |t|
      t.string :url

      t.timestamps
    end
  end
end
