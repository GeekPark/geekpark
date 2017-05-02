# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  process :optimize

  def optimize
    manipulate! do |img|
      return img unless img.mime_type.match /image\/jpeg/
      img.strip
      img.combine_options do |c|
        c.quality "80"
        c.depth "8"
        c.interlace "plane"
      end
      img
    end
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{id_partition}"
  end

  # 根据文件名分区
  def id_partition
    model.read_attribute(mounted_as)[0,4].insert(2, '/')
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename
  end

  private

  def secure_token
    var = :"@_#{mounted_as}_secure_token"
    model.instance_variable_get(var) ||
      model.instance_variable_set(var, SecureRandom.hex)
  end
end
