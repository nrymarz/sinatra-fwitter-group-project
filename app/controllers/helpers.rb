class Helpers
    def self.logged_in?(session)
        !!session[:user_id]
    end

    def self.current_user(session)
        User.find_by_id(session[:user_id])
    end
end