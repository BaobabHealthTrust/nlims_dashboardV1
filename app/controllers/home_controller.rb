class HomeController < ApplicationController
    def home
        @doing_settings = false
        @sites = Site.where(:enabled => true)		
    end




    def login      
        @login = true
    end


    def authenticate
        username = params[:username]
        password = params[:password]
        
		user = User.where(username: username).first
	
		if user 
			secured_pass =  BCrypt::Password.new(user['password'])
            if secured_pass == password && username == user['username']
                session['user'] = username
                session['id'] = user['id']
				render plain: "authenticated" and return
			else
                render plain: "wrong username or password"  and return
			end
		else
			render plain: "user account not found" and return
		end
	end


    def encrypt_password(password)

		return BCrypt::Password.create(password)
	end


	def decrypt_password(password)
		return BCrypt::Password.new(password)
	end


    def create_account

    end


    def load_account_details

    end

    def edit_account

    end


end
