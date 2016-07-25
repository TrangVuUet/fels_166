User.create!(name: "TrangVu",
  email: "trangvuuet@gmail.com",
  password: "Trang1912",
  password_confirmation: "Trang1912")

99.times do |n|
  name  = Faker::Name.name + "djdhd"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end
