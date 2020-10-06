class PetsController < ApplicationController

  def index
    @pets = ["pet 1", "pet 2"]
  end

end
