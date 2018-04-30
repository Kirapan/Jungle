class SessionsController < ApplicationController
  def new
  end

  def create
    if @user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = @user.id
      redirect_to [:products], success: "Login successfully"
    else
      redirect_to new_session_path, danger: "wrong email or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to products_path, success: "Logout successfully"
  end

end
