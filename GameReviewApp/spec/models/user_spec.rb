require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前、ニックネーム、Eメール、パスワードがある場合、有効である" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "名前が無い場合、無効である" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "名前が31文字以上の場合、無効である" do
    user = FactoryBot.build(:user, name: 'a' * 31)
    user.valid?
    expect(user.errors[:name]).to include("は30文字以内で入力してください")
  end

  it "ニックネームが無い場合、無効である" do
    user = FactoryBot.build(:user, nickname: nil)
    user.valid?
    expect(user.errors[:nickname]).to include("を入力してください")
  end

  it "ニックネームが3文字以下の場合、無効である" do
    user = FactoryBot.build(:user, nickname: 'a' * 3)
    user.valid?
    expect(user.errors[:nickname]).to include("は4文字以上で入力してください")
  end

  it "ニックネームが31文字以上の場合、無効である" do
    user = FactoryBot.build(:user, nickname: 'a' * 31)
    user.valid?
    expect(user.errors[:nickname]).to include("は30文字以内で入力してください")
  end

  it "メールアドレスが無い場合、無効である" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "メールアドレスとして使用できない文字列の場合、無効である" do
    user = FactoryBot.build(:user, email: ".abc@abc")
    user.valid?
    expect(user.errors[:email]).to include("は不正な値です")
  end

  it "重複したメールアドレスの場合、無効である" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.build(:user)
    user2.valid?
    expect(user2.errors[:email]).to include("はすでに存在します")
  end

  it "パスワードが無い場合、無効である" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "パスワードが8文字未満の場合、無効である" do
    user = FactoryBot.build(:user, password: '1' * 7)
    user.valid?
    expect(user.errors[:password]).to include("は8文字以上で入力してください")
  end

  it "パスワードが129文字以上の場合、無効である" do
    user = FactoryBot.build(:user, password: '1' * 129)
    user.valid?
    expect(user.errors[:password]).to include("は128文字以内で入力してください")
  end

end

