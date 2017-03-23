module SmartFilterable
  extend ActiveSupport::Concern

  class_methods do
    def smart_filter(params)
      (params || {}).to_h.inject(all) do |results, (key, val)|
        results.smart_filter_key_val(key, val)
      end
    end

    private

    def smart_filter_key_val(key, val)
      col = columns_hash[key]
      case col.type
      when :string
        all.smart_filter_string(key, val)
      when :datetime
        all.smart_filter_datetime(key, val)
      when :int
        all.smart_filter_enum(key, val) if key.in? defined_enums
      else
        Rails.logger.warn "Filtering column does not exist or invalid: #{key}"
      end
    end

    def smart_filter_string(key, val)
      all.where("#{key} LIKE ?", "%#{val}%")
    end

    def smart_filter_enum(key, val)
      all.where(key => self.class.defined_enums[key][val])
    end

    def smart_filter_datetime(key, val)
      day = case val
            when 'today', 'yesterday', 'tomorrow'
              Date.public_send(val)
            else
              Date.parse(val)
            end
      all.where(key => day.beginning_of_day..day.end_of_day)
    end
  end
end
