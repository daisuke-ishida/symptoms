module UsersHelper
    def gravatar_for(user, options = { size: 80 })
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
    
    def current_user
        if session[:user_id]
          @current_user || User.find_by(id: session[:user_id])
        elsif cookies.signed[:user_id]
          @current_user || User.find_by_id_and_auto_login_token(
              cookies.signed[:user_id],cookies.signed[:auto_login_token])
        end
    end
    
end
