require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

Faker::Config.locale = 'en'
puts "🎬 Creating fake movie data..."

5.times do
  create(:movie)
end

puts "✅ Done seeding movies!"