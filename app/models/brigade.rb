# == Schema Information
#
# Table name: brigades
#
#  id          :integer          not null, primary key
#  event_id    :integer
#  position_id :integer
#  quantity    :integer
#  visible     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Brigade < ActiveRecord::Base
  belongs_to :event
  belongs_to :position
end
