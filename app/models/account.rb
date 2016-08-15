# == Schema Information
#
# Table name: accounts
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  degree_before :integer
#  degree_after  :integer
#  birth_name    :string
#  birth_date    :string
#  gender        :integer
#  birth_place   :string
#  birth_number  :string
#  nationality   :string
#  family_status :integer
#  bank_acc      :string
#  insurance     :string
#  occupation    :string
#  terms         :boolean
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Account < ActiveRecord::Base
  belongs_to :user
  
  enum degree_before: [:ing, :phdr]
  enum degree_after: [:csc, :dis]
  enum gender: { "muž" => 0, "žena" => 1 }
  enum family_status: { "svobodný/á" => 0, "ženatý/vdaná" => 1, "vdovec/vdova" => 2 }
  
  enum status: [:started, :ended, :completed]
  
  # set default entries
  after_initialize :set_default_values, :if => :new_record?
  
  def set_default_values
    self.status ||= :started
    self.terms  ||= false
  end
end
