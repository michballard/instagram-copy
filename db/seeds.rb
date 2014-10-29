# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Post.destroy_all

post_1 = Post.new(title: "The dark pier")
post_1.image = File.open('app/assets/images/seed_images/image_1.jpg')
post_1.save!

post_2 = Post.new(title: "Birds flying to a tree")
post_2.image = File.open('app/assets/images/seed_images/image_2.jpg')
post_2.save!

post_3 = Post.new(title: "Time to take a break")
post_3.image = File.open('app/assets/images/seed_images/image_3.jpg')
post_3.save!

post_4 = Post.new(title: "Riding through the sunset")
post_4.image = File.open('app/assets/images/seed_images/image_4.jpg')
post_4.save!

post_5 = Post.new(title: "Under my umbrella")
post_5.image = File.open('app/assets/images/seed_images/image_5.jpg')
post_5.save!

post_6 = Post.new(title: "Pier to infinity")
post_6.image = File.open('app/assets/images/seed_images/image_6.jpg')
post_6.save!

post_7 = Post.new(title: "More piers")
post_7.image = File.open('app/assets/images/seed_images/image_7.jpg')
post_7.save!

post_8 = Post.new(title: "Bright front door")
post_8.image = File.open('app/assets/images/seed_images/image_8.jpg')
post_8.save!

post_9 = Post.new(title: "Sunset")
post_9.image = File.open('app/assets/images/seed_images/image_9.jpg')
post_9.save!

post_10 = Post.new(title: "Mustang")
post_10.image = File.open('app/assets/images/seed_images/image_10.jpg')
post_10.save!