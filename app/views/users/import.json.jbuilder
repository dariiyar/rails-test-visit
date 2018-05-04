json.users @users.each do |user|
  json.(user, :name, :number, :description, :date, :id)
  json.delete_path user_path(user)
end
