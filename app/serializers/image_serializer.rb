class ImageSerializer < ApplicationSerializer
  attributes :id,
             :url

  def url
    object.file.url
  end
end
