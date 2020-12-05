class TweetsController < ApplicationController
    get '/tweets' do 
        if Helpers.logged_in?(session)
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end

end
