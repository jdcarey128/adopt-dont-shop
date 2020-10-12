class SheltersController < ApplicationController

  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create
    shelter = Shelter.new({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip],
      })

    shelter.save
    redirect_to '/shelters'
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip],
      })

    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to "/shelters"
  end

  def pets_index
    @pets = [Pet.where(shelter_id: params[:shelter_id])].flatten
  end

  def pet_new
  end

  def pet_create
    Pet.create(pet_params)
    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end

  def pet_edit
    @pet = Pet.find(params[:pets_id])
  end

  def pet_update
    pet = Pet.find(params[:pet_id])
    pet.update(pet_params)
    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end

  def pet_destroy
    Pet.destroy(params[:pet_id])
    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end

  private
  def pet_params
    params.permit(:image, :name, :description, :approximate_age, :sex, :shelter_id)
  end

  def shelter_params
    params.require(:shelter).permit(:image, :name, :description, :approximate_age, :sex, :shelter_id)
  end


end
