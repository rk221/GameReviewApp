class UserMailer < ApplicationMailer
    default from: 'rkApp@example.com'
    def creation_email(user)
        @user = user
        mail(
            subject: 'ユーザー登録完了メール',
            to: user.email,
            from: 'rkApp@example.com'
        )
    end
end
