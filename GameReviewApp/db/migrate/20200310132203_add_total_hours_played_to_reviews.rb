class AddTotalHoursPlayedToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :total_hours_played, :integer, null: false, limit: 9999, default: 1
  end
end
