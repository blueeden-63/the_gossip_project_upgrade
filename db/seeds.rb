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

# Create anonymous user (used for gossip creation without authentication)
User.create!(first_name: "anonymous", last_name: "user", email: "anonymous@gossip.com", description: "Utilisateur anonyme", age: 1, city: paris)

# Create users
users = [
  User.create!(first_name: "Alice", last_name: "Dupont", email: "alice@gossip.com", description: "Developpeuse passionnee", age: 25, city: paris),
  User.create!(first_name: "Bob", last_name: "Martin", email: "bob@gossip.com", description: "Designer creatif", age: 28, city: lyon),
  User.create!(first_name: "Charlie", last_name: "Bernard", email: "charlie@gossip.com", description: "Chef de projet", age: 32, city: marseille),
  User.create!(first_name: "Diana", last_name: "Petit", email: "diana@gossip.com", description: "Directrice marketing", age: 30, city: paris),
  User.create!(first_name: "Eva", last_name: "Moreau", email: "eva@gossip.com", description: "Graphic designer", age: 26, city: lyon),
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
    title: "Nouveau cafe",
    content: "Vous devez absolument essayer leur espresso, c'est dingue!",
    user: users[0],
    created_at: 2.days.ago
  ),
  Gossip.create!(
    title: "Bug en prod",
    content: "Les variables s'affichaient en reverse pour une raison inconnue. Ca m'a pris 3h a debuguer!",
    user: users[1],
    created_at: 1.day.ago
  ),
  Gossip.create!(
    title: "Reunion",
    content: "Nous faisons une reunion demain pour celebrer nos 100 utilisateurs! Venez tous avec vos idees!",
    user: users[2],
    created_at: 12.hours.ago
  ),
  Gossip.create!(
    title: "Campagne pub",
    content: "Notre nouvelle campagne est allee live! Attendez de voir les resultats...",
    user: users[3],
    created_at: 6.hours.ago
  ),
  Gossip.create!(
    title: "Potins bureau",
    content: "Voici notre super site de potins, il est chouette, non?",
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
