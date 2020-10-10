class AddAdoptionStatusToPet < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :adoption_status, :boolean
  end
end
