class QuizzesMailer < ApplicationMailer

  def new_quiz(quiz)
    # we're definingn instance variables here so we can
    # access them in the view file
    @quiz = quiz
    @owner = @quiz.user

    mail(
      to: 'hello.quizzy.mail@gmail.com',
      subject: 'You created and new quiz'
    )
  end

end
