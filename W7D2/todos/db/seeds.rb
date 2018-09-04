# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
todos = Todo.create([
  { title: "Buy milk", body: "Whole please", done: false },
  { title: "Eat cheese", body: "It's tasty", done: false },
  { title: "Order pizza", body: "So you can eat the cheese", done: false },
  { title: "Buy popcorn", body: "To do this amazing thing", done: false },
  { title: "Buy bittersweet chocolate", body: "We're gonna create something amazing", done: false },
  { title: "Combination", body: "Combine butter, popcorn, and three squares of bittersweet chocolate in microwave-safe bowl", done: false },
  { title: "Microwave", body: "Enjoy!", done: false }
  ])
