class SessionsController < Devise::SessionsController
  
  respond_to :json

  def create
    super do |user|
      if request.format.json?
        data = {
          token: user.authentication_token,
          email: user.email,
          admin: user.role == 'admin'
        }
        render json: data, status: 201 and return
      end
    end
  end
end
