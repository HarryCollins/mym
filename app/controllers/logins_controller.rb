class LoginsController < ApplicationController
    
    def new
    
    end
    
    def create
        user = User.find_by(username: params[:identifier])
        user ||=  User.find_by(email: params[:identifier])
        if user && user.authenticate(params[:password])
            if user.email_confirmed?
                session[:user_id] = user.id
                flash.now[:success] = "You are logged in"
                redirect_to root_path
            else
                flash.now[:error] = 'Please activate your account by following the 
                instructions in the account confirmation email you received to proceed'
                render 'new'                
            end
        else
            flash.now[:danger] = "Your username and password do not match"
            render 'new'
        end
    end
    
    def destroy
        session[:user_id] = nil
        flash[:success] = "You have logged out"
        redirect_to root_path
    end    
    
end
