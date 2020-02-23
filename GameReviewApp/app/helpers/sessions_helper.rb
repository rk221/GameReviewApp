module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    def logged_in?
        !current_user.nil?
    end

    #ユーザーのログイン情報を永続的セッションにする
    def remember(user)
        user.remember 
        cookies.permanent.signed[:user_id] = user.id 
        cookies.permanent[:remember_token] = user.remember_token
    end

    #ログイン中のユーザーを返す
    def current_user
        if (user_id = session[:user_id])                                #セッションに存在する
            @current_user ||= User.find_by(id: user_id)
        elsif(user_id = cookies.signed[:user_id])                       #クッキーに存在する
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])    #クッキーとダイジェストが一致
                log_in user
                @current_user = user
            end
        end
    end

    #永続的セッションを破棄する
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
end
