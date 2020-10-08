require 'rails_helper'

describe "As a user" do
  describe "when the user visits '/shelters/:id'" do
    it "the user sees a link to delete the shelter" do

      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      visit "/shelters/#{shelter_1.id}"

      # save_and_open_page
      expect(page).to have_button("Delete Shelter")
    end

    it "the user is redirected to the '/shelters' page and no longer sees the deleted shelter upon click the 'Delet Shelter' link" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")

      visit "/shelters/#{shelter_1.id}"
      click_button("Delete Shelter")
      expect(page).to eq("/shelters")
      expect(page).to have_content(shelter_2.name)
      expect(page).to have_content(shelter_2.address)
      expect(page).to have_content(shelter_2.city)
      expect(page).to have_content(shelter_2.state)
      expect(page).to have_content(shelter_2.zip)
    end


  end
end
