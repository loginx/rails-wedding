ActiveAdmin.register User do
  index do
    id_column
    column :full_name
    column :email
    column :created_at
    column :updated_at
    column :role
  end
end
