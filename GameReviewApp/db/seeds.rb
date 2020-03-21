# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "adminuser", nickname: "管理者ユーザー", email: "admin@example.com", password: 'password')

10.times do |no|
    User.create(name: "テスト用名前#{no}", nickname: "ニックネーム#{no}", email: "email#{no}@example.com", password: 'password')
    genre = Genre.create(name: "テストジャンル#{no}", description: "これはテストジャンルです")
    Game.create(name: "テストゲーム#{no}", genre_id: genre.id)
end


Review.create(title: "テストタイトル", comment: "これはテストレビューです", user_id: 1, game_id: 1)
