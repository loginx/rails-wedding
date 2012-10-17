class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.boolean :attending
      t.references :rsvp
      t.string :diet
      t.string :email

      t.timestamps
    end
    add_index :guests, :rsvp_id
  end
end
