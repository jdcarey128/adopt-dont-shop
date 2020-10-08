require 'rails_helper'

describe "As a user" do
  describe "when the user visits '/shelters'" do
    it "the user sees the name of each shelter in the system and the user sees a 'New Shelter' link" do

      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")

      visit '/shelters'

      expect(page).to have_link(shelter_1.name)
      expect(page).to have_link(shelter_2.name)
      expect(page).to have_link("New Shelter")
    end

    xit "the user is routed to '/shelters/new' when they click on the 'New Shelter' link" do
      visit '/shelters'

      click_link("New Shelter")
      expect('/shelters').to eq('/shelters/new')
    end

  end
end
