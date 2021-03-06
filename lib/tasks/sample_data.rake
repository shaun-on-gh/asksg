namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "admin",
                 email: "admin@asksg.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    5.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@asksg.com"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    dictionary = ["maths", "english", "science", "astrology", "chinese", "malay"]
    100.times do |n|
      title = Faker::Lorem.sentence()
      content = Faker::Lorem.sentences(5)
      tag_list = dictionary.shuffle.take(3).join(' ')
      users[n % 6].questions.create!(title: title,
                                     content: content,
                                     tag_list: tag_list)
    end
    questions = Question.all(limit: 8)
    3.times do |n|
      content = Faker::Lorem.sentences(3)
      questions.each do |question| 
        answer = question.answers.build(content: content)
        answer.user = users[n]
        answer.save!
      end
    end
  end
end