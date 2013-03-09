class Media < ActiveRecord::Base
  attr_accessible :order, :url, :active, :flavor, :playlist_id, :start_time, :end_time
  belongs_to :playlist

  validates_presence_of :url, :order
end
