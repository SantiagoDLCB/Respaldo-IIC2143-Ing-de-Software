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
  user = User.new(email: 'jmun@uc.cl', password: 'chavales', password_confirmation: 'chavales', name: 'Jorge', last_name: 'Muñoz', username: 'Dios')

  user.save!
  user.add_role(:admin)
  puts "Admin seeded successfully."
else
  puts "Admin already exists. Skipping seeding."
end
