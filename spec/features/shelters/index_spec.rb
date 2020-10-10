require 'rails_helper'

describe "As a user" do
  describe "when I visit '/shelters'" do
    it "I see the name of each shelter in the system and I see a 'New Shelter' link" do

      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")

      visit '/shelters'

      expect(page).to have_link(shelter_1.name)
      expect(page).to have_link(shelter_2.name)
      expect(page).to have_link("New Shelter")
    end

    it "I am routed to '/shelters/new' when I click on the 'New Shelter' link" do
      visit '/shelters'

      click_link("New Shelter")
      expect(current_path).to eq('/shelters/new')
    end

    describe "user story 13" do
      it "I can click on an 'edit shelter' link for each listed shelter" do
        shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
        shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")

        visit "/shelters"

        within("#shelter_#{shelter_1.id}") do
          expect(page).to have_link("edit shelter")
          click_link("edit shelter")
          expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")
        end

        visit "/shelters"

        within("#shelter_#{shelter_2.id}") do
          expect(page).to have_link("edit shelter")
          click_link("edit shelter")
          expect(current_path).to eq("/shelters/#{shelter_2.id}/edit")
        end
      end
    end

    describe "user story 14" do
      it "I can delete a shelter from the shelter index" do
        shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
        shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")

        visit "/shelters"

        within("#shelter_#{shelter_1.id}") do
          expect(page).to have_button("delete shelter")
          click_button("delete shelter")
          expect(current_path).to eq("/shelters")
        end

        expect(page).to_not have_content(shelter_1.name)

        visit "/shelters"

        within("#shelter_#{shelter_2.id}") do
          expect(page).to have_button("delete shelter")
          click_button("delete shelter")
          expect(current_path).to eq("/shelters")
        end

        expect(page).to_not have_content(shelter_2.name)

      end
    end

  end
end
