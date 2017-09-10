class UsersController < ApplicationController

	before_action :require_user, except: [:new,  :create]
	before_action :require_user_is_self, only: [:show, :update]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
	    @user = User.new(user_params)

		if @user.save
			UserMailer.registration_confirmation(@user).deliver_now
			flash[:success] = "Please confirm your email address"
			#session[:user_id] = @user.id
			#redirect_to users_path
			redirect_to root_path	
		else
      		render :new
    	end

  	end

  	def show
  		@user = User.find(params[:id])
  		
  	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
	    if @user.update(user_params)
	      flash[:success] = "You have sucessfully updated your information"  
	      redirect_to user_path(@user)
	    else
	      render :edit
	    end
	end

	def confirm_email
		user = User.find_by_confirm_token(params[:id])
		if user
			user.email_activate
			flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
			Please sign in to continue."
			redirect_to login_path
		else
			flash[:error] = "Sorry. User does not exist"
			redirect_to root_path
		end
	end

	private

	def user_params
		params.require(:user).permit(:firstname, :secondname, :username, :email, :password)
	end

	def require_user_is_self
		#user can only see/update their own details
		redirect_to root_path if current_user != User.find(params[:id])
	end

end
