require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit a shelter pets index page" do
    it "I see a form to add an adoptable pet" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      pet_1 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                        name: "Tony",
                        approximate_age: "2",
                        sex: "male",
                        description: "He is just the best!")


      visit "/shelters/#{shelter_1.id}/pets"

      click_on("Create Pet")

      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")

      expect(page).to have_content("image")
      expect(find_field("image").value).to eq(nil)

      expect(page).to have_content("name")
      expect(find_field("name").value).to eq(nil)

      expect(page).to have_content("description")
      expect(find_field("description").value).to eq(nil)

      expect(page).to have_content("approximate age")
      expect(find_field("approximate age").value).to eq(nil)

      expect(page).to have_content("sex")
      expect(find_field("sex").value).to eq(nil)

      fill_in "image", with: "https://dogtime.com/assets/uploads/gallery/golden-retriever-dogs-and-puppies/golden-retriever-dogs-puppies-10.jpg"
      fill_in "name", with: "Rover"
      fill_in "description", with: "Cute golden retriever with lots of energy!"
      fill_in "approximate age", with: "3"
      fill_in "sex", with: "male"

      click_on("Create Pet")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

      expect(page).to have_xpath("//img[contains(@src, https://dogtime.com/assets/uploads/gallery/golden-retriever-dogs-and-puppies/golden-retriever-dogs-puppies-10.jpg)]")
      expect(page).to have_content("Rover")
      expect(page).to have_content("Cute golden retriever with lots of energy!")
      expect(page).to have_content("3")
      expect(page).to have_content("male")
    end
  end
end
