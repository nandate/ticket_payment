ActiveAdmin.register Event do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  config.sort_order = "name_asc"

  filter :name
  filter :description

  index do
    selectable_column
    column :id
    column :name
    column :description
    actions
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs do
      f.input :name
      f.input :description
      f.input :image_url
    end
    f.inputs do
      f.has_many :performances, heading: "Performances", allow_destroy: true do |fp|
        fp.input :start_time
        fp.input :end_time
      end
    end
    f.actions
  end

end
