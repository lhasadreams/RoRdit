ActiveAdmin.register User do

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :created_at
  end

  filter :username
  filter :email
  filter :created_at
end
