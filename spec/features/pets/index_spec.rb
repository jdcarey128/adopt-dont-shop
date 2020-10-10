require 'rails_helper'

RSpec.describe "As a user" do
  describe "when I visit the '/pets' webpage" do
    it "I see each Pet including their image, name, approximate age, sex, and name of shelter" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")
      pet_1 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                        name: "Tony",
                        approximate_age: "2",
                        sex: "male",
                        description: "He is just adorable!")
      pet_2 = shelter_2.pets.create(image: "https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg",
                                    name: "Isabell",
                                    approximate_age: "5",
                                    sex: "female",
                                    description: "Just the cutest!")
      visit '/pets'

      # within(".pet_#{pet_1.id}") do
        expect(page).to have_xpath("//img[contains(@src, '#{pet_1.image}')]")
        expect(page).to have_content(pet_1.name)
        expect(page).to have_content(pet_1.approximate_age)
        expect(page).to have_content(pet_1.sex)
        expect(page).to have_content(pet_1.shelter.name)
      # end

      # within(".pet_#{pet_2.id}") do
        expect(page).to have_xpath("//img[contains(@src, '#{pet_2.image}')]")
        expect(page).to have_content(pet_2.name)
        expect(page).to have_content(pet_2.approximate_age)
        expect(page).to have_content(pet_2.sex)
        expect(page).to have_content(pet_2.shelter.name)
      # end
    end

    describe "user story 15/16" do
      it "I can edit each pet's information" do
        shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
        shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")
        pet_1 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                          name: "Tony",
                          approximate_age: "2",
                          sex: "male",
                          description: "He is just adorable!")
        pet_2 = shelter_2.pets.create(image: "https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg",
                                      name: "Isabell",
                                      approximate_age: "5",
                                      sex: "female",
                                      description: "Just the cutest!")

        visit "/pets"

        within("#pet_#{pet_1.id}") do
          expect(page).to have_link("edit pet")
          click_link("edit pet")
        end

        expect(current_path).to eq("/pets/#{pet_1.id}/edit")
        expect(find_field("image").value).to eq(pet_1.image)
        expect(find_field("name").value).to eq(pet_1.name)
        expect(find_field("description").value).to eq(pet_1.description)
        expect(find_field("approximate_age").value).to eq(pet_1.approximate_age)
        expect(find_field("sex").value).to eq(pet_1.sex)


        visit "/pets"

        within("#pet_#{pet_2.id}") do
          expect(page).to have_link("edit pet")
          click_link("edit pet")
        end

        expect(current_path).to eq("/pets/#{pet_2.id}/edit")
        expect(find_field("image").value).to eq(pet_2.image)
        expect(find_field("name").value).to eq(pet_2.name)
        expect(find_field("description").value).to eq(pet_2.description)
        expect(find_field("approximate_age").value).to eq(pet_2.approximate_age)
        expect(find_field("sex").value).to eq(pet_2.sex)

      end

      it "I can delete a pet" do
        shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
        shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")
        pet_1 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                          name: "Tony",
                          approximate_age: "2",
                          sex: "male",
                          description: "He is just adorable!")
        pet_2 = shelter_2.pets.create(image: "https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg",
                                      name: "Isabell",
                                      approximate_age: "5",
                                      sex: "female",
                                      description: "Just the cutest!")

        visit "/pets"

        within("#pet_#{pet_1.id}") do
          expect(page).to have_link("delete pet")
          click_link("delete pet")
        end

        expect(current_path).to eq("/pets")
        expect(page).to_not have_content("Name: #{pet_1.name}")
        expect(page).to_not have_content("Approximate age: #{pet_1.approximate_age}")
        expect(page).to_not have_content("Sex: #{pet_1.sex}")
        expect(page).to_not have_content("Sex: #{pet_1.shelter}")

        visit "/pets"

        within("#pet_#{pet_2.id}") do
          expect(page).to have_link("delete pet")
          click_link("delete pet")
        end

        expect(current_path).to eq("/pets")
        expect(page).to_not have_content("Name: #{pet_2.name}")
        expect(page).to_not have_content("Approximate age: #{pet_2.approximate_age}")
        expect(page).to_not have_content("Sex: #{pet_2.sex}")
        expect(page).to_not have_content("Sex: #{pet_2.shelter}")
      end
    end
  end
end
