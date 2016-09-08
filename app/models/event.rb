# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string
#  description :string
#  start_date  :string
#  end_date    :string
#  manager     :integer
#  visible     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ActiveRecord::Base
  
  belongs_to :user
  has_many :event_addresses, dependent: :destroy
  accepts_nested_attributes_for :event_addresses, reject_if: proc { |attributes| attributes['street'].blank? || attributes['street_number'].blank? || attributes['city'].blank? }
  #attr_reader :title
  
  
  validates_presence_of :user_id
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :manager
  validates_inclusion_of :visible, in: [true, false]
  
  
  
end
