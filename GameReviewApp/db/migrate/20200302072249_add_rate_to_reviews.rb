class AddRateToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :rate, :integer, null: false, limit: 5, default: 1
  end
end
