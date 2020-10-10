class ChangeAdoptionStatusToBeStringInPet < ActiveRecord::Migration[5.2]
  def change
    change_column :pets, :adoption_status, :string
  end
end
