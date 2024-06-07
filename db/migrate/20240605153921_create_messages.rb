class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :from_id
      t.string :from_name
      t.text :body
      t.references :room_chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
