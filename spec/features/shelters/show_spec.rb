require 'rails_helper'

describe "As a user" do
  describe "when I visit '/shelters/:id'" do
    it "I see the shelter's name, address, city, state, and zip and see a link to 'Update Shelter' and 'Delete Shelter'" do

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

    it "I am taken to '/shelters/:id/edit' when I click 'Update Shelter'" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      visit "/shelters/#{shelter_1.id}"

      click_button("Update Shelter")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")
      # below looks at url params
      # expect(page).to have_current_path("/shelters/#{shelter_1.id}/edit")
    end

    it "I am taken to '/shelters' when I click 'Delete Shelter' and the shelter is not listed in index" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")

      visit "/shelters/#{shelter_1.id}"

      click_button("Delete Shelter")
      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content("Colorado Cares")
      expect(page).to have_content("Rocky Mountain High")
    end

    it "I can access the shelter's pet index" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      pet_1 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                        name: "Tony",
                        approximate_age: "2",
                        sex: "male",
                        description: "Pretty cute as far as dogs go.")
      pet_2 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg",
                                    name: "Isabell",
                                    approximate_age: "5",
                                    sex: "female",
                                    description: "Just the cutest!")
      visit "/shelters/#{shelter_1.id}"

      click_on("Shelter's Pets")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
      expect(page).to have_xpath("//img[contains(@src, '#{pet_1.image}')]")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.approximate_age)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_content(pet_1.shelter.name)

      expect(page).to have_xpath("//img[contains(@src, '#{pet_2.image}')]")
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_2.approximate_age)
      expect(page).to have_content(pet_2.sex)
      expect(page).to have_content(pet_2.shelter.name)
    end

  end
end
