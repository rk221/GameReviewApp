crumb :root do
  link "Home", root_path
end

crumb :login do
  link "ログイン画面", login_path
end

crumb :new_user do
  link "ユーザー登録", new_user_path
  parent :login
end

crumb :confirm_new_user do
  link "ユーザー登録確認", confirm_new_user_path
  parent :new_user
end

crumb :user do
  link "マイページ", user_path
end

crumb :edit_user do
  link "ユーザー編集", edit_user_path
  parent :user
end

crumb :confirm_edit_user do
  link "ユーザー編集確認", confirm_user_path
  parent :edit_user
end

crumb :confirm_destroy_user do
  link "ユーザー削除確認", confirm_user_path
  parent :user
end

crumb :reviews do
  link "レビュー一覧", reviews_path
end

crumb :new_review do
  link "レビュー投稿", new_review_path
  parent :reviews
end

crumb :games do
  link "ゲーム一覧", games_path
end

crumb :game do
  link "ゲーム詳細", game_path
  parent :games
end

crumb :genres do
  link "ジャンル一覧", genres_path
end

crumb :genre do
  link "ジャンル詳細", genre_path
  parent :genres
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).