# == Schema Information
#
# Table name: positions
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  requirements :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Position < ActiveRecord::Base
  has_many :brigades
  
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :requirements
  
end
