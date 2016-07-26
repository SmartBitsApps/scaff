# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  brigade_id :integer
#  user_id    :integer
#  approved   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subscription < ActiveRecord::Base
  belongs_to :brigade
  belongs_to :user
end
