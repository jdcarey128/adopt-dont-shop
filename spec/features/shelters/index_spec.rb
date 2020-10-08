require 'rails_helper'

describe "As a user" do
  describe "when the user visits '/shelters'" do
    it "the user sees the name of each shelter in the system" do

      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")

      visit '/shelters'
      
      expect(page).to have_link(shelter_1.name)
      expect(page).to have_link(shelter_2.name)
    end
  end
end
