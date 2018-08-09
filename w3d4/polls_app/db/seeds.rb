# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Poll.delete_all
Question.delete_all
AnswerChoice.delete_all
Response.delete_all

users = User.create!([{username: "ben"}, {username: "brandon"}, {username: "bb"}, {username: "jake"}])

polls = Poll.create([
                      {user_id: users.first.id, title: "Ice Cream"},
                      {user_id: users.second.id, title: "Diets"},
                      {user_id: users.third.id, title: "Plants"},
                      {user_id: users.first.id, title: "Coffee"}
                    ])

questions = Question.create([
                              {poll_id: polls.first.id, text: "What's your favorite Ice Cream?"},

                              {poll_id: polls.second.id, text: "What's your favorite diet?"},

                              {poll_id: polls.third.id, text: "What's your favorite plant?"}
                            ])

answer_choices = AnswerChoice.create([
                                      {question_id: questions.first.id, text: "Cherry Ice Cream"},
                                      {question_id: questions.first.id, text: "Chocolate"},
                                      {question_id: questions.first.id, text: "Vanilla"},
                                      {question_id: questions.first.id, text: "Strawberry"},

                                      {question_id: questions.second.id, text: "Atkins"},
                                      {question_id: questions.second.id, text: "Paleo"},
                                      {question_id: questions.second.id, text: "Keto"},
                                      {question_id: questions.second.id, text: "Soul Food"},

                                      {question_id: questions.third.id, text: "House Plant"},
                                      {question_id: questions.third.id, text: "Lavender"},
                                      {question_id: questions.third.id, text: "A Weed"},
                                      {question_id: questions.third.id, text: "Ayahuasca"}
                                    ])

responses = Response.create([
                              {user_id: users.second.id, answer_choice_id: answer_choices.first.id},
                              {user_id: users.third.id, answer_choice_id: answer_choices.second.id},
                              {user_id: users.second.id, answer_choice_id: answer_choices[5].id},
                              {user_id: users.first.id, answer_choice_id: answer_choices[10].id}
                            ])
