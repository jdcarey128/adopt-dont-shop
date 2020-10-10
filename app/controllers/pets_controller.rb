class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:pet_id])
  end

  def self.adoption_status(status)
    return "Adoptable" if status
    return "Pending" if !status
  end

end
