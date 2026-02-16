class CreatePrivateMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :private_messages do |t|
      t.text :content
      t.references :sender, null: false, foreign_key: true

      t.timestamps
    end
  end
end
