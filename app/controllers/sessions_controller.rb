class SessionsController < ApplicationController
  before_action :logged_in_redirect_to, only:[:new,:create]
 def new
 end
 def create
     user = User.find_by(username: params[:session][:username])
     if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "you have succefully logged in"
      redirect_to root_path
     else
       flash.now[:error] = "There is something wrong with your details "
       render 'new'
     end
 end
 def destroy
  session[:user_id] = nil
  flash[:success] = "you logged out successfully"
  redirect_to login_path
 end
 private

 def logged_in_redirect_to
   if logged_in?
     flash[:error] = "you are alredy logged_in"
     redirect_to root_path
   end

 end
end
