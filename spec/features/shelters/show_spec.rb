require 'rails_helper'

describe "As a user" do
  describe "when the user visits '/shelters/:id'" do
    it "the user sees the shelter's name, address, city, state, and zip and sees a link to 'Update Shelter' and 'Delete Shelter'" do

      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_1.address)
      expect(page).to have_content(shelter_1.city)
      expect(page).to have_content(shelter_1.state)
      expect(page).to have_content(shelter_1.zip)
      expect(page).to have_button("Update Shelter")
      expect(page).to have_button("Delete Shelter")
    end

    it "the user is taken to '/shelters/:id/edit' when they click 'Update Shelter'" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      visit "/shelters/#{shelter_1.id}"

      click_button("Update Shelter")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")
      # below looks at url params
      # expect(page).to have_current_path("/shelters/#{shelter_1.id}/edit")
    end

    it "the user is taken to '/shelters' when they click 'Delete Shelter' and the shelter is not listed in index" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")

      visit "/shelters/#{shelter_1.id}"

      click_button("Delete Shelter")
      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content("Colorado Cares")
      expect(page).to have_content("Rocky Mountain High")
    end

  end
end
