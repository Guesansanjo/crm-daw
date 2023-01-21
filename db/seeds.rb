# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create(email: 'jus@gmail.com', password: 'password')

10.times do
  User.create(email: Faker::Internet.email, password: 'password')
end

5.times do |i|
  Board.create(user:, name: "Board #{i + 1}")
end

Board.find_each do |board|
  5.times { |i| List.create(board:, title: "List #{i + 1}", position: i) }

  board.reload.lists.each do |list|
    5.times { |i| Item.create(list:, title: "List #{i + 1}") }
  end
end
