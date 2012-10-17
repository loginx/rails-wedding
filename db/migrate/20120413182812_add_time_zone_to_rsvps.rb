class AddTimeZoneToRsvps < ActiveRecord::Migration
  def change
    add_column :rsvps, :time_zone, :string
  end
end
