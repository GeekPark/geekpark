module HasMeta
  extend ActiveSupport::Concern

  included do
    before_save :fill_in_default_meta
  end

  private

  def fill_in_default_meta
    self.meta = {} if meta.nil?
    self.class::META_VARIABLES.each do |var, value|
      next if meta[var].present?
      meta[var] = value
    end
  end
end
