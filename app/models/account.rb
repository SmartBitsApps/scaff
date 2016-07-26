class Account < ActiveRecord::Base
  belongs_to :user
  
  enum degree_before: [:ing, :phdr]
  enum degree_after: [:csc, :dis]
  enum gender: { "muž" => 0, "žena" => 1 }
  enum family_status: { "svobodný/á" => 0, "ženatý/vdaná" => 1, "vdovec/vdova" => 2 }
  
  enum status: [:ended, :started, :completed]
  
  # set default entries
  after_initialize :set_default_values, :if => :new_record?
  
  def set_default_values
    self.status ||= :started
    self.terms  ||= false
  end
end
