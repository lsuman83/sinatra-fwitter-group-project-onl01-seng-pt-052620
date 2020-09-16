class TweetsController < ApplicationController

    get "/tweets" do

        @tweets = Tweet.all

        if Helpers.is_logged_in?(session)
            erb :'/tweets/tweets'
        else
            redirect "/login"
        end

    end

    get "/tweets/new" do
    
        if Helpers.is_logged_in?(session)
            erb :'/tweets/new'
        else
            @error = "You must be logged in to create tweets"
            redirect "/login"
        end
        
    end

    post "/tweets" do
        
        @user = Helpers.current_user(session)

        
        if @user && !params[:content].empty?
            @user.tweets << Tweet.create(content: params[:content])
        else
            redirect "/tweets/new"
        end
            
        redirect "/tweets/#{@user.tweets.last.id}"
    
    end

    get "/tweets/:id" do

        @tweet = Tweet.find_by_id(params[:id])

        if Helpers.is_logged_in?(session)
            erb :'/tweets/show_tweet'
        else
            redirect "/login"
        end

    end

    get "/tweets/:id/edit" do
    
        @tweet = Tweet.find_by_id(params[:id])
        
        if Helpers.is_logged_in?(session)
            erb :'/tweets/edit_tweet'
        else
            redirect "/login"
        end

    end

    patch "/tweets/:id" do

        @tweet = Tweet.find_by_id(params[:id])
        
        if !params[:content].empty?
            @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end

    end

    delete "/tweets/:id" do

        @tweet = Tweet.find_by_id(params[:id])
        
        if Helpers.current_user(session) == @tweet.user
            @tweet.destroy
        end

        redirect "/tweets"
    end
    

end
