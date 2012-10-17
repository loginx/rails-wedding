ActiveAdmin.register Rsvp do
  controller do
    defaults :finder => :find_by_uuid
  end
end
