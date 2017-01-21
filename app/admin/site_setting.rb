ActiveAdmin.register SiteSetting do
  permit_params :title, :logo, :slogan

  index do
    selectable_column
    id_column
    column :title
    column :slogan
    column :logo do |setting|
      image_tag(setting.logo, size: "75x75")
    end
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Site Details" do
      f.input :title
      f.input :slogan
      f.input :logo, as: :file, hint: "75x75 pixels"
    end
    f.actions
  end

end
