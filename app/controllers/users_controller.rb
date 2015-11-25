class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:index, :destroy]
    before_action :authenticate_admin!, only: [:index, :destroy]

    before_action :set_user, only: [:destroy]

    def index
      @users = User.all
      render :json => @users.to_json
    end

    def destroy
      @user.destroy
      render :json => @user
    end

    private

      def set_user
        @user = User.find(params[:id])
      end
end
