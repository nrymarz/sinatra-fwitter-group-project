class UsersController < ApplicationController
    get '/signup' do 
        if !Helpers.logged_in?(session)
            erb :'/users/signup'
        else
            redirect '/tweets'
        end
    end

    get '/login' do
        if !Helpers.logged_in?(session)
            erb :'/users/login'
        else
            redirect '/tweets'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    post '/signup' do
        user = User.new(params)
        if user.username.size > 0 && user.email.size >0 && user.save
            session[:user_id] = user.id 
            redirect "/tweets"
        else
            redirect '/users/signup'
        end
    end

    post '/login' do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else
            @error = "Could not login"
            erb :'/users/login'
        end
    end

    get '/logout' do 
        if Helpers.logged_in?(session)
            session.clear
            redirect '/login'
        else
            redirect '/'
        end
    end
  
end
