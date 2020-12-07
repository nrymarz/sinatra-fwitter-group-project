class TweetsController < ApplicationController
    get '/tweets' do 
        if Helpers.logged_in?(session)
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do 
        if Helpers.logged_in?(session)
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        if Helpers.logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        if Helpers.logged_in?(session)
            if Helpers.current_user(session) == @tweet.user
                erb :'/tweets/edit'
            else
                redirect '/tweets'
            end
        else
            redirect '/login'
        end
    end

    post '/tweets' do 
        if params[:content].size > 0 && Helpers.logged_in?(session)
            tweet = Tweet.create(content: params[:content])
            user = Helpers.current_user(session)
            user.tweets << tweet
            user.save
            redirect "/users/#{user.slug}"
        else
            @error = "Write Something in the Content"
            redirect '/tweets/new'
        end
    end

    patch '/tweets/:id' do 
        if params[:content].size > 0 && Helpers.logged_in?(session)
            tweet = Tweet.find(params[:id])
            tweet.update(content: params[:content])
            redirect "/users/#{tweet.user.slug}"
        else
            redirect "/tweets/#{params[:id]}/edit"
        end
    end

    delete '/tweets/:id' do
        tweet = Tweet.find(params[:id]) 
        if Helpers.logged_in?(session)
            if Helpers.current_user(session) == tweet.user
                tweet.destroy
                redirect '/tweets'
            else
                redirect '/tweets'
            end
        else
            redirect '/login'
        end
    end


end
