class SessionsController < ApplicationController

    def create
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
        # Grabbing user id and storing it on the session/ cookies
        session[:user_id] = user.id
        #Returns the logged in user after getting the user_id
        render json: user, status: :created 
        else
            render json: { error: "Invalid username or password" }, status: :unauthorized
        end
        
    end

    def destroy
        #deleting the user_id from the session store
        session.delete :user_id
        head :no_content
    end

end
