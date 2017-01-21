ActiveAdmin.register SmtpSetting do
  permit_params :user_name, :password, :port, :address, :authentication, :domain, :default_from

  index do
    selectable_column
    id_column
    column :user_name
    column :port
    column :address
    column :authentication
    column :domain
    column :default_from
    column :created_at
    actions
  end

  controller do
    def update
      if params[:smtp_setting][:password].blank?
        params[:smtp_setting].delete "password"
      end
      super
    end
  end

  form do |f|
    f.inputs "SMTP Settings" do
      f.input :user_name
      f.input :password
      f.input :port
      f.input :address
      f.input :authentication, hint: "plain or login"
      f.input :domain
      f.input :default_from, hint: "RoRdit <noreply@example.com>"
    end
    f.actions
  end
end
