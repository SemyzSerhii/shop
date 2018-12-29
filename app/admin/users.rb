ActiveAdmin.register User do
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

  permit_params :name, :email, :password, :access

  scope :all
  scope :block
  scope :unblock

  action_item :block, only: :show do
    link_to 'Block', block_admin_user_path(user), method: :put if user.access
  end

  action_item :unblock, only: :show do
    link_to 'Unblock', unblock_admin_user_path(user), method: :put unless user.access
  end

  member_action :block, method: :put do
    user = User.find(params[:id])
    user.update(access: false)
    redirect_to admin_user_path(user), notice: 'User was blocked.'
  end

  member_action :unblock, method: :put do
    user = User.find(params[:id])
    user.update(access: true)
    redirect_to admin_user_path(user), notice: 'User was unblocked.'
  end
end
