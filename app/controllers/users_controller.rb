class UsersController < ApplicationController

	before_action :require_user, except: [:index,  :new,  :create]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
	    @user = User.new(user_params)

		if @user.save
			flash[:success] = "Your account has been created successfully"
			session[:user_id] = @user.id
			redirect_to users_path				
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
	      flash[:success] = "You have sucessfully updated this user"  
	      redirect_to users_path
	    else
	      render :edit
	    end
	end

	private

	def user_params
		  params.require(:user).permit(:firstname, :secondname, :email, :password)
	end

end
