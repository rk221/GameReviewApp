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
            UserMailer.creation_email(@user).deliver_now #メール送信
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

        if params[:back].present?
            render :edit
            return
        end
        
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

    def confirm_edit
        @user = User.find(params[:id])
        return if current_user != @user
        
        #動的に値の更新
        user_params.each do |attr_symbol, param|
            @user.send("#{attr_symbol.to_s}=", param)
        end

        render :edit unless @user.valid?
    end

    def confirm_destroy
        @user = User.find(params[:id])
        return if current_user != @user
        render action: :confirm_destroy
    end

    private
    
    def user_params
        params.require(:user).permit(:id, :name, :nickname, :email, :password, :password_confirmation)
    end
end
