class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end
    
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            #リダイレクト
            redirect_to sessions_path, notice: '新規ユーザーを登録しました'
        else
            render :new     #登録に失敗した
        end
    end

    private
    
    def user_params
        params.require(:user).permit(:id, :name, :email, :password, :password_confirmation)
    end
end
