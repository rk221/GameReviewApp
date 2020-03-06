class AddRateToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :graphic_rate, :integer, null: false, limit: 5, default: 1
    add_column :reviews, :sound_rate, :integer, null: false, limit: 5, default: 1
    add_column :reviews, :management_rate, :integer, null: false, limit: 5, default: 1
    add_column :reviews, :story_rate, :integer, null: false, limit: 5, default: 1
    add_column :reviews, :volume_rate, :integer, null: false, limit: 5, default: 1
  end
end
