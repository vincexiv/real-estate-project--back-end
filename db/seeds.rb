puts "🌱 Seeding data..."

puts "🌱 house categories..."
mansion = Category.create(category: "Mansion")
bungalow = Category.create(category: "Bungalow")
one_bedroom = Category.create(category: "1 Bedroom")
two_bedroom = Category.create(category: "2 Bendroom")
three_bedroom = Category.create(category: "3 Bedroom")
bedsitter = Category.create(category: "Bedsitter")

puts "🌱 locations..."
nairobi = Location.create(location: "Nairobi")
mombasa = Location.create(location: "Mombasa")
kisumu = Location.create(location: "Kisumu")

puts "🌱 houses..."
20.times do
  House.create(
    location_id: [nairobi, mombasa, kisumu].sample.id,
    category_id: [mansion, bungalow, one_bedroom, two_bedroom, three_bedroom, bedsitter].sample.id,
    price: rand(10000..150000).to_f,
    description: Faker::Lorem.paragraph(sentence_count: rand(2..5)),
    size_in_sqft: rand(20..10000),
    image: "https://via.placeholder.com/#{rand(500..1000)}x#{rand(200..700)}"
  )
end

puts "🌱 Done seeding!"
