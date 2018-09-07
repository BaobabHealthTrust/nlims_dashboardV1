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

        
    def add_account
        username = params[:username]
        password = params[:password]
        email   = params[:email]
        phone   = params[:phone]
        location = params[:location]
        name    = params[:name]
        status = false

        encr_password = encrypt_password(password)

        if check_user(username) == true
            user = User.new
            user.app_name = "dashboard user"
            user.partner = name
            user.password = encr_password
            user.username = username
            user.location = location
            user.token = ""
            user.token_expiry_time = Time.new
            user.save()
            status = true
        end        
        render plain: status and return  
    end

    def check_user(username)
        rs = User.where(:username => username)
        if !rs.blank?
            return false
        else
            return true
        end
    end

    def get_location()
        rs = Site.find_by_sql("SELECT DISTINCT sites.district AS dist FROM sites")
        render plain: rs.to_json and return
    end


end
