User.create!(name: "TrangVu",
  email: "trangvuuet@gmail.com",
  password: "Trang1912",
  password_confirmation: "Trang1912",
  admin: true)
10.times do |n|
  name  = Faker::Name.name + "djdhd"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow followed}
followers.each {|follower| follower.follow user}
Category.create! name:"English"
5.times do |n|
  name  = Faker::Name.name
  Category.create! name: name
end
Word.create! content:"Xin chao"
5.times do |n|
  name  = Faker::Name.name
  Word.create!(content: name,
    category_id: 1)
end
5.times do |n|
  name  = Faker::Name.name
  Word.create!(content: name,
    category_id: 5)
end
5.times do |n|
  name  = Faker::Name.name
  Word.create!(content: name,
    category_id: 2)
end
5.times do |n|
  name  = Faker::Name.name
  Word.create!(content: name,
    category_id: 3)
end
5.times do |n|
  name  = Faker::Name.name
  Word.create!(content: name,
    category_id: 4)
end
WordAnswer.create! content:"Xin chao"
4.times do |n|
  name  = Faker::Name.name
  WordAnswer.create!(content: name,is_correct: false,
    word_id: 1)
end
4.times do |n|
  name  = Faker::Name.name
  WordAnswer.create!(content: name,is_correct: false,
    word_id: 2)
end
4.times do |n|
  name  = Faker::Name.name
  WordAnswer.create!(content: name,is_correct: false,
    word_id: 3)
end
4.times do |n|
  name  = Faker::Name.name
  WordAnswer.create!(content: name,is_correct: false,
    word_id: 4)
end
4.times do |n|
  name  = Faker::Name.name
  WordAnswer.create!(content: name,is_correct: false,
    word_id: 5)
end
6.times do |n|
  name  = Faker::Name.name
  Lesson.create!(is_complete: false,user_id: 1,
    category_id: 1)
end
