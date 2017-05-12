module HasImageField
  extend ActiveSupport::Concern

  class_methods do
    def image_field(name)
      belongs_to name, class_name: 'Image'

      define_method "#{name}_url" do
        (send name)&.file&.url
      end
    end
  end
end
