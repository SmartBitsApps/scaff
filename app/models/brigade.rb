class Brigade < ActiveRecord::Base
  belongs_to :event
  belongs_to :position
end
