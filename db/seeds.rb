# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data (safely)
[GossipTag, Gossip, Comment, Like, User, Tag, City].each do |model|
  begin
    model.delete_all
  rescue => e
    puts "Skipping #{model}: #{e.message}"
  end
end

# Create cities
paris = City.create!(name: "Paris", zip_code: "75000")
lyon = City.create!(name: "Lyon", zip_code: "69000")
marseille = City.create!(name: "Marseille", zip_code: "13000")

# Create users
users = [
  User.create!(first_name: "Alice", last_name: "Dupont", description: "Développeuse passionnée", age: 25, city: paris),
  User.create!(first_name: "Bob", last_name: "Martin", description: "Designer créatif", age: 28, city: lyon),
  User.create!(first_name: "Charlie", last_name: "Bernard", description: "Chef de projet", age: 32, city: marseille),
  User.create!(first_name: "Diana", last_name: "Petit", description: "Directrice marketing", age: 30, city: paris),
  User.create!(first_name: "Eva", last_name: "Moreau", description: "Graphic designer", age: 26, city: lyon),
]

# Create tags
tags = [
  Tag.create!(title: "Fun"),
  Tag.create!(title: "Important"),
  Tag.create!(title: "Secret"),
  Tag.create!(title: "News"),
  Tag.create!(title: "Drôle"),
]

# Create gossips
gossips = [
  Gossip.create!(
    title: "Le nouveau café du coin est incroyable!",
    content: "Vous devez absolument essayer leur espresso, c'est dingue! ",
    user: users[0],
    created_at: 2.days.ago
  ),
  Gossip.create!(
    title: "J'ai trouvé un bug bizarre en production",
    content: "Les variables s'affichaient en reverse pour une raison inconnue. Ça m'a pris 3h à déboguer! ",
    user: users[1],
    created_at: 1.day.ago
  ),
  Gossip.create!(
    title: "Réunion d'équipe ",
    content: "Nous faisons une réunion demain pour célébrer nos 100 utilisateurs! Venez tous avec vos idées!",
    user: users[2],
    created_at: 12.hours.ago
  ),
  Gossip.create!(
    title: "Nouvelle campagne marketing lancée",
    content: "Notre nouvelle campagne est allée live! Attendez de voir les résultats... ",
    user: users[3],
    created_at: 6.hours.ago
  ),
  Gossip.create!(
    title: "Derniers potins du bureau ",
    content: "Voici notre super site de potins, il est chouette, non? ",
    user: users[4],
    created_at: 3.hours.ago
  ),
]

# Link gossips to tags
gossips[0].tags << tags[0] << tags[3]
gossips[1].tags << tags[1] << tags[2]
gossips[2].tags << tags[0] << tags[3]
gossips[3].tags << tags[1] << tags[4]
gossips[4].tags << tags[0] << tags[4]

puts " #{User.count} users created"
puts " #{Gossip.count} gossips created"
puts " #{Tag.count} tags created"
puts " Database seeded successfully!"
