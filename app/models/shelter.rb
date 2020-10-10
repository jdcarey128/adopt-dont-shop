class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy

  validates_presence_of :name

end
