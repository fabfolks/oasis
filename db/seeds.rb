# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

puts 'Creating houses and members'
File.readlines("#{Rails.root}/extras/houses.txt").each do |line|
  line.chomp!
  house = House.create(:name => line)
  puts "  House: #{house.name}"
  name_password = "oasis#{line.gsub('-', '').downcase}"
  member = Member.create(:username => name_password, :password => name_password, :password_confirmation => name_password, :house_id => house.id, :role => 'admin')
  puts "  Member:#{member.username}"
end
puts 'Finished'
