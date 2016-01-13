class AddCounterCache < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :tweets_count
    end

    change_table :tweets do |t|
      t.integer :votes_count
    end
  end
end
