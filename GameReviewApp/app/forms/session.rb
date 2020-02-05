class Session
    include ActiveModel::Model

    attr_accessor :email, :password

    validates :email, presence:true
    validates :password, presence: true

    validate :true_email_and_password

    def true_email_and_password
        user = User.find_by(email: email)
        if user.nil? || !user.authenticate(password)
            errors[:base] <<("#{Session.human_attribute_name(:email)}もしくは#{Session.human_attribute_name(:password)}が間違っています。")
        end
    end

    def save
        return false if invalid?
        true
    end
end