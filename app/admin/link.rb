ActiveAdmin.register Link do
  permit_params :title, :url

  index do
    selectable_column
    id_column
    column :title
    column :url
    column :created_at
    column :popularity
    column :user
    actions
  end

  filter :user
  filter :title
  filter :url
  filter :created_at
  filter :popularity
  filter :hostname
end
