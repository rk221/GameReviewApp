class UsersController < ApplicationController
    skip_before_action :login_required, only: [:new, :create, :confirm_new]
    def index #UserIndex View only by administrator in the future
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

        if params[:back].present?
            render :new
            return
        end

        if @user.save
            redirect_to login_path, notice: 'ユーザーを登録しました。'
        else
            render :new     #登録に失敗した
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])

        return if current_user != @user
        
        #User Update Validate
        if @user.update(user_params)
            redirect_to user_path(params[:id]), notice: 'ユーザー情報を更新しました。'
        else
            render :edit
        end
    end

    def destroy
        user = User.find(params[:id])   #User Delete
        user.destroy                    

        reset_session                   #Session Delete
        redirect_to login_path, noice: 'ユーザーデータを削除しました'
    end

    def confirm_new
        @user = User.new(user_params)
        render :new unless @user.valid?
    end

    private
    
    def user_params
        params.require(:user).permit(:id, :name, :nickname, :email, :password, :password_confirmation)
    end
end
