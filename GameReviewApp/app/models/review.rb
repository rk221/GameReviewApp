class Review < ApplicationRecord
    belongs_to :user
    belongs_to :game
    has_many :likes_for_user_reviews, dependent: :destroy

    validates :title, presence: true, length: {maximum: 50}
    validates :comment, presence: true, length: {maximum: 200}
    validates :total_hours_played, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 9999}
    validates :graphic_rate, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
    validates :sound_rate, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
    validates :management_rate, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
    validates :story_rate, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
    validates :volume_rate, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}

    mount_uploader :image, ImageUploader

    scope :selectOrderHash, -> {
         {'投稿時間の早い順' => 'create_at_desc', '平均評価の高い順' => 'avg_rate_desc', 'グラフィックの高い順' => 'graphic_rate_desc', 'サウンドの高い順' => 'sound_rate_desc', '運営の高い順' => 'management_rate_desc', 'ストーリーの高い順' => 'story_rate_desc', 'ボリュームの高い順' => 'volume_rate_desc'}
    }

    def self.selectOrderSql(order_val)
        case order_val
        when 'create_at_desc' then
            return 'created_at desc'
        when 'avg_rate_desc' then
            return '((graphic_rate + sound_rate + management_rate + story_rate + volume_rate) / 5) desc'
        when 'graphic_rate_desc' then
            return 'graphic_rate desc'
        when 'sound_rate_desc' then
            return 'sound_rate desc'
        when 'management_rate_desc' then
            return 'management_rate desc'
        when 'story_rate_desc' then
            return 'story_rate desc'
        when 'volume_rate_desc' then
            return 'volume_rate desc'
        else
            return 'created_at desc'
        end
    end

    scope :selectDateHash, -> {
        {'全期間' => 'all', '１日以内' => 'day','１週間以内' => 'week', '１か月以内' => 'month', '半年以内' => 'half_year'}
    }

    def self.selectDateSql(date_val)
        case date_val
        when 'day' then
            return 1.day.ago
        when 'week' then
            return 1.week.ago
        when 'month' then
            return 1.month.ago
        when 'half_year' then
            return 6.month.ago
        else
            return ""
        end
    end
end