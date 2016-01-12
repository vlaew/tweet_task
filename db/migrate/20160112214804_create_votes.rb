class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :tweet, null: false, index: true
      t.timestamp :created_at, null: false
    end

    add_foreign_key :votes, :users, on_delete: :cascade
    add_foreign_key :votes, :tweets, on_delete: :cascade
  end
end
