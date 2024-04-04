# app/controllers/users/registrations_controller.rb
def update_resource(resource, params)
    return super if params['password'].present?
  
    resource.update_without_password(params.except('current_password'))
  end