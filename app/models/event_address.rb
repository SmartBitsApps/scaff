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
  
  validates_presence_of :event_id, on: :update
  validates_presence_of :street, on: :update
  validates_presence_of :street_number, on: :update
  validates_presence_of :city, on: :update
  
end
