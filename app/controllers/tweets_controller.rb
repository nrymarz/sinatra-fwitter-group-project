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
        erb :'/tweets/edit'
    end

end
