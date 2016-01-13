class AddDefaultForCounterCache < ActiveRecord::Migration
  def self.up
    change_column_default :tweets, :votes_count, 0
    change_column_default :users, :tweets_count, 0
  end

  def self.down
    change_column_default :tweets, :votes_count, nil
    change_column_default :users, :tweets_count, nil
  end
end
