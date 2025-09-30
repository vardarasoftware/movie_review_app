# Load all fixture files from test/fixtures
require 'active_record/fixtures'
require 'factory_bot_rails'

# Clear existing data
puts "Cleaning database..."
[AdminUser, User, Movie, Genre, MovieGenre, Rating, Comment].each do |model|
  model.destroy_all
end

# Load fixtures in specific order due to dependencies
fixtures_path = Rails.root.join('test', 'fixtures')

# Load fixtures in order
fixture_tables = [
  'admin_users',
  'users',
  'genres',
  'movies',
  'movie_genres',
  'ratings',
  'comments'
]

fixture_tables.each do |table|
  puts "Loading #{table} fixtures..."
  ActiveRecord::FixtureSet.create_fixtures(fixtures_path, table)
end

FactoryBot.create_list(:movie, 100)

puts "Seed data loaded successfully!"