class Playlist < ActiveRecord::Base
  attr_accessible :name, :items_attributes
  belongs_to :user
  has_many :items, :class_name => 'Media', :order => '"order"'

  validates_presence_of :user

  accepts_nested_attributes_for :items
end
