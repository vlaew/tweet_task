class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :user, index: true, null: false
      t.text :text, limit: 140

      t.timestamp :created_at, null: false
    end

    add_foreign_key :tweets, :users, on_delete: :cascade
  end
end
