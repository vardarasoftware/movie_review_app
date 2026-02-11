require 'faker'
require 'open-uri'
require 'securerandom'

puts "🌱 Seeding started..."

Rating.destroy_all
Review.destroy_all
Movie.destroy_all
Genre.destroy_all
User.destroy_all

puts "Creating users..."

20.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email.downcase,
    password: "harishkhileri",
    password_confirmation: "harishkhileri"
  )
end

puts "✅ Users created"

genres = [
  "Action", "Comedy", "Drama", "Horror",
  "Romance", "Sci-Fi", "Thriller", "Adventure"
]

genres.each do |name|
  Genre.create!(name: name)
end

puts "✅ Genres created"

users = User.all

20.times do
  Movie.create!(
    title: Faker::Movie.title,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    release_date: Faker::Date.between(from: 20.years.ago, to: Date.today),
    genre: Genre.all.sample,
    user: users.sample
  )
end

puts "🎬 Movies created"

# Attach posters
Movie.find_each do |movie|
  next if movie.avatar.attached?

  file = URI.open("https://picsum.photos/300/450?random=#{SecureRandom.uuid}")
  movie.avatar.attach(io: file, filename: "poster.jpg", content_type: "image/jpeg")
end

puts "🖼 Posters attached"

# Ratings & Reviews
Movie.find_each do |movie|
  users.sample(rand(2..5)).each do |user|
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
