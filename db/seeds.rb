# frozen_string_literal: true
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#

unless User.exists?(username: 'Dios')
  # Create example user
  user = User.new(email: 'jmun@uc.cl', password: 'DCChavales', password_confirmation: 'DCChavales', name: 'Jorge', last_name: 'Muñoz', username: 'Dios')
  user.save!
  user.add_role(:admin)
  puts "Admin seeded successfully."
else
  puts "Admin already exists. Skipping seeding."
end

unless User.exists?(username: 'vjsm')
  # Create example user
  user = User.new(email: 'vjsm@uc.cl', password: 'DCClave', password_confirmation: 'DCClave', name: 'Vicente', last_name: 'San Martín', username: 'vjsm')
  user.save!
  puts "vjsm seeded successfully."
else
  puts "vjsm already exists. Skipping seeding."
end

unless User.exists?(username: 'ainfantep')
  # Create example user
  user = User.new(email: 'ainfante@uc.cl', password: 'DCContraseña', password_confirmation: 'DCContraseña', name: 'Andres', last_name: 'Infante', username: 'ainfantep')
  user.save!
  puts "ainfantep seeded successfully."
else
  puts "ainfantep already exists. Skipping seeding."
end

unless User.exists?(username: 'sa.dlcb')
  # Create example user
  user = User.new(email: 'sa.delacarrera@uc.cl', password: 'DCCifrado', password_confirmation: 'DCCifrado', name: 'Santiago', last_name: 'de la Carrera', username: 'sa.dlcb')
  user.save!
  puts "sa.dlcb seeded successfully."
else
  puts "sa.dlcb already exists. Skipping seeding."
end
