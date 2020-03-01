# frozen_string_literal: true

module ReviewDecorator
    #作成日を〇時間前のように表示する
    def convert_elapsed_time
        elapsed_second = Time.zone.now - read_attribute(:updated_at)

        return read_attribute(:updated_at).strftime("%Y年%m月%d日") if calc_second_to_date(elapsed_second) > 10
        return "#{calc_second_to_date(elapsed_second)}日前" if calc_second_to_date(elapsed_second) > 0
        return "#{calc_second_to_hour(elapsed_second)}時間前" if calc_second_to_hour(elapsed_second) > 0
        return "#{calc_second_to_minute(elapsed_second)}分前" if calc_second_to_minute(elapsed_second) > 0
        return "#{elapsed_second.floor}秒前"
    end

    def calc_second_to_date(second)
        return (second / (60 * 60 * 24)).floor
    end

    def calc_second_to_hour(second)
        return (second / (60 * 60)).floor
    end

    def calc_second_to_minute(second)
        return (second / 60).floor
    end
end
