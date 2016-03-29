class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.integer :phone
      t.string :email
      t.text :address1
      t.text :address2
      t.string :city
      t.string :state
      t.integer :zip

      t.timestamps null: false
    end
  end
end
