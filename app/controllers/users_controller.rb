class UsersController < ApplicationController
  
  def new
    @user= User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      
      session[:user_id] = @user.id
      redirect_to [:products], success: 'Registration successful!'
    else 
      if @user.errors[:password].any?
        redirect_to new_user_path, danger: 'password must be at least 6 characters long'
      elsif @user.errors[:password_confirmation].any?
        redirect_to new_user_path, danger: 'Passwords don\'t match'
      elsif @user.errors[:email].any?
        redirect_to new_user_path, danger: 'Email already exists'
      else
        redirect_to new_user_path, danger: 'All fields are mandatory'
      end
    end 
  end


  private
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email, 
      :password,
      :password_confirmation)
  end
end
