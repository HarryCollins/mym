class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
	    @user = User.new(user_params)
	    account = Account.new(user: @user, balance: 10)

	    #need to modify to test for possibility of user saving and account not saving
		if @user.save && account.save 
			flash[:success] = "Your account has been created successfully"
			session[:user_id] = @user.id
			redirect_to users_path				
		else
      		render :new
    	end

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

	def account
		@user = User.find(params[:id])
		@account = @user.account

		render :account
	end


	private

	def user_params
		  params.require(:user).permit(:firstname, :secondname, :email, :password)
	end

end
