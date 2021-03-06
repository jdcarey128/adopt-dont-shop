class Pet < ApplicationRecord
  belongs_to :shelter
  after_initialize :init

  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :adoption_status

  def init
    self.adoption_status ||= "adoptable"
  end

end
