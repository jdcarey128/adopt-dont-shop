require 'rails_helper'

RSpec.describe "As a user" do
  describe "When I click on 'Update Pet' on '/pets/:pet_id' webpage" do
    it "I can edit a pet's image, name, description, approximate age, and sex" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      pet_1 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                        name: "Tony",
                        approximate_age: "2",
                        sex: "male",
                        description: "Pretty cute as far as dogs go.")
      visit "/pets/#{pet_1.id}"

      click_on("Update Pet")
      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      expect(find_field("image").value).to eq(pet_1.image)
      expect(find_field("name").value).to eq(pet_1.name)
      expect(find_field("description").value).to eq(pet_1.description)
      expect(find_field("approximate_age").value).to eq(pet_1.approximate_age)
      expect(find_field("sex").value).to eq(pet_1.sex)

      fill_in "name", with: "Rebecca"
      fill_in "approximate_age", with: "3"
      fill_in "sex", with: "female"

      click_button("Update Pet")
      expect(current_path).to eq("/pets/#{pet_1.id}")

      expect(page).to have_content("Rebecca")
      expect(page).to_not have_content("Tony")
      expect(page).to have_content("Approximate age: 3")
      expect(page).to_not have_content("Approximate age: 2")
      expect(page).to have_content("Sex: female")
      expect(page).to_not have_content("Sex: male", exact:true)

    end

  end
end
