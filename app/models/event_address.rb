# == Schema Information
#
# Table name: event_addresses
#
#  id            :integer          not null, primary key
#  event_id      :integer
#  street        :string
#  street_number :string
#  city          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class EventAddress < ActiveRecord::Base
  belongs_to :event
  
  validates_presence_of :event_id
  validates_presence_of :street
  validates_presence_of :street_number
  validates_presence_of :city
  
end
