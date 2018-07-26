20.times do |n|
  name  = "Nga Ngo"
  email = "nga-#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password,
               role: "0",
               )
end
users = User.all
user  = users.first
following = users[1..9]
followers = users[1..3]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
