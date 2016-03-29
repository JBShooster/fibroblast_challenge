# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(username:'tester', password:'abcde12345', email:'tester@gmail.com', first_name:'Tester', last_name:'Helper')
Contact.create(first_name:'John', last_name:'Smith', phone:12129999999, email:'johnnysmith@yahoo.com', address1:'555 New Hope', city:'Tatooine', state:'NY', zip:20002, user_id:1)