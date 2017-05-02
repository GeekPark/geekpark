# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  file       :string
#  usage      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ApplicationRecord
  validates :file, presence: true

  mount_uploader :file, ImageUploader
end
