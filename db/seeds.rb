# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Quiz.destroy_all
Question.destroy_all
Answer.destroy_all


PASSWORD = "supersecret"

codecore_user = User.create(
    username: "Educator",
    email: "educator@gmail.com",
    password: PASSWORD,
    educator: true
)

10.times do
    name = Faker::Name.first_name
    email = "#{name.downcase}@example.com"
    User.create(
        username: name,
        email: email,
        password: PASSWORD
    )
end
users = User.all


5.times do 
    #CREATING 5 QUIZZES
    created_at = Faker::Date.backward(365 * 5)
    q = Quiz.create(
        name: Faker::Hacker.say_something_smart,
        created_at: created_at,
        updated_at: created_at,
        user: codecore_user
    )

    #CREATE QUESTIONS (if quizzes are valid)
    if q.valid?
        2.times do
        qtn = Question.new(
            body: Faker::Hacker.say_something_smart,
            created_at: created_at,
            updated_at: created_at,
            quiz_id: q.id
        )
        q.questions << qtn
        if qtn.valid?
            4.times do
                a = Answer.create(
                    body: Faker::Hacker.say_something_smart,
                    created_at: created_at,
                    updated_at: created_at,
                    question_id: qtn.id,
                )
                end
            end
        end
    end
end



users = User.all
quizzes = Quiz.all
questions = Question.all
answers = Answer.all

puts "Created #{users.count} users"
puts "Created #{questions.count} questions"
puts "Created #{answers.count} answers"

