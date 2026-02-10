require 'faker'

puts "🌱 Seeding started..."

Rating.destroy_all
Review.destroy_all
Movie.destroy_all
Genre.destroy_all

genres = [
  "Action", "Comedy", "Drama", "Horror",
  "Romance", "Sci-Fi", "Thriller", "Adventure"
]

genres.each do |name|
  Genre.create!(name: name)
end

puts "✅ Genres created"

20.times do
  Movie.create!(
    title: Faker::Movie.title,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    release_date: Faker::Date.between(from: 20.years.ago, to: Date.today),
    poster_url: Faker::Internet.url(host: "example.com", path: "/poster.jpg"),
    genre: Genre.all.sample
  )
end

puts "🎬 Movies created"

users = User.all

raise "No users found! Seed users first." if users.empty?

Movie.find_each do |movie|
  users.sample(rand(7..10)).each do |user|
    Rating.create!(
      rating: rand(1..5),
      user: user,
      movie: movie
    )

    Review.create!(
      body: Faker::Lorem.sentence(word_count: 15),
      user: user,
      movie: movie
    )
  end
end

puts "⭐ Ratings & Reviews created"
puts "🌱 Seeding completed!"


# puts "Cleaning database..."

# User.delete_all
# AdminUser.delete_all

# Faker::UniqueGenerator.clear

# puts "Creating users..."

# 20.times do
#   User.create!(
#     name: Faker::Name.name,
#     email: Faker::Internet.unique.email.downcase,
#     password: "harishkhileri",
#     password_confirmation: "harishkhileri"
#   )
# end
