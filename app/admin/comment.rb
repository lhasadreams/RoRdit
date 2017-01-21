ActiveAdmin.register Comment do
  permit_params :comment

  index do
    selectable_column
    id_column
    column :comment
    column "Link Title" do |l|
      l.link.title
    end
    column :created_at
    column :user
    actions
  end

  filter :user
  filter :link
  filter :comment
  filter :created_at
end
