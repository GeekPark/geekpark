# -*- SkipSchemaAnnotations
class SiteConfig < RailsSettings::Base
  source    Rails.root.join('config/app.yml')
  namespace Rails.env

  def self.columns
    return @columns if @columns
    @columns = OpenStruct.new
    self['column_names'].each do |key, title|
      @columns[key] = Column
                      .create_with(description: title)
                      .find_or_create_by(title: title)
    end
    @columns
  end
end
