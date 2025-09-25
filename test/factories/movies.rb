FactoryBot.define do
  factory :movie do
    title { Faker::Movie.unique.title }
    
    description do
      paragraphs = Array.new(rand(2..4)) do
        [
          Faker::Movies::Hobbit.quote,
          Faker::Movies::StarWars.quote,
          Faker::Books::Lovecraft.paragraph,
          Faker::Quotes::Shakespeare.hamlet_quote
        ].sample
      end
      paragraphs.join(" ")
    end
    
    release_date { Faker::Date.between(from: '2000-01-01', to: '2025-09-30') }
    director { Faker::Name.name }
    writer { Faker::Name.name }
    banner_url { Faker::Internet.url(host: 'example.com', path: "/#{Faker::Lorem.word}.jpg") }
    average_rating { rand(1.0..5.0).round(1) }
    ratings_count { rand(1..1000) }
  end
end
