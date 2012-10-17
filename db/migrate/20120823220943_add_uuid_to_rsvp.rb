class AddUuidToRsvp < ActiveRecord::Migration
  def change
    add_column :rsvps, :uuid, :uuid, :index => true
  end
end
