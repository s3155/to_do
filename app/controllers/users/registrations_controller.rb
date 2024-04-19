# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  def build_resource(hash = {})
    hash[:uid] = User.maximum(:uid).to_i + 1
    super
  end

  def update_resource(resource, params)
    return super if params['password'].present?
  
    resource.update_without_password(params.except('current_password'))
  end
end
