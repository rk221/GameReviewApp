class ApplicationController < ActionController::Base
    before_action :login_required #Login only
    include SessionsHelper

    private
    
    #ログイン中のユーザーが存在しなければログイン画面へ遷移させる
    def login_required
        redirect_to login_path unless current_user
    end
end
