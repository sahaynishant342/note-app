class UserController < ApplicationController
  # TODO: understand csrf and find a way to fix token issue instead of bypassing the check
  skip_before_action :verify_authenticity_token

  def create
    @user = User.new(allowed_params)
    @user.generate_n_set_encrypted_password(params[:user][:password])
    @user.generate_n_set_activation_code
    @user.set_status false

    begin
      @user.save
      activation_link = "http://localhost:3000/user/activate_account?email=#{@user.email}&q=#{@user.activation_code}"
      UserMailer.account_created(@user, activation_link).deliver_later # email will be sent async
      render "tell_about_activation"
    rescue Exception => ex
      puts "Exception occurred : #{ex.message}"
      @msg = "Unable to create account"
      render "error_occurred"
    end
  end

  def activate_account
    @user = User.find_by_email(params[:email])
    if @user
      if @user.activation_code == params[:q]
        @user.set_status true
        @user.save
        render "account_activated"
      else
        @msg = "Activation link is not correct"
        render "error_occurred"
      end
    else
      @msg = "Unable to find record with email : #{params[:email]}"
      render "error_occurred"
    end
  end

  def index
  end

  private

  def allowed_params
    params.require(:user).permit(:name, :email)
  end

end
