class UsersController < ApplicationController

    

    get "/signup" do

        if Helpers.is_logged_in?(session)
            redirect "/tweets"
        else
            erb :'/users/create_user'
        end

    end

    post "/signup" do

        @user = User.new(username: params[:username], email: params[:email], password: params[:password])    
        
        if @user.save 
            session[:id] = @user.id
            redirect "/tweets" 
        else
            redirect '/signup' 
        end
    
    end


    get "/login" do
        
        if Helpers.is_logged_in?(session)
            redirect "/tweets"
        else
            erb :'/users/login'
        end

    end

    post "/login" do
        
        @user = User.find_by(username: params[:username])
        
        if @user && @user.authenticate(params[:password])
            session[:id] = @user.id
            redirect "/tweets"
        else
            redirect "/login"
        end

    end

    get "/users/:slug" do

        @user = User.find_by_username(params[:slug])
        session[:id] = @user.id

        if Helpers.is_logged_in?(session)
            erb :'/users/show'
        else
            redirect "/login"
        end

    end

    get "/logout" do

        if Helpers.is_logged_in?(session)
            session.clear
            redirect "/login"
        else
            redirect "/"
        end

    end        

end
