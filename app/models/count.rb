# == Schema Information
#
# Table name: counts
#
#  id             :integer          not null, primary key
#  countable_type :string
#  countable_id   :integer
#  count          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_counts_on_countable_id_and_countable_type  (countable_id,countable_type)
#

class Count < ApplicationRecord
  belongs_to :countable, polymorphic: true
end
