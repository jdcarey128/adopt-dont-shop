class Pet < ApplicationRecord

  validates_presence_of :image
  validates_presence_of :name 

end
