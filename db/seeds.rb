# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create(name:'kevin',email:'superadmin@gmail.com',phone:'9875648561',gender:'male',state_id: '1', city_id: '1',password:'superadmin123',password_confirmation:'superadmin123')
user1.add_role :superadmin
user2 = User.create(name:'pradip',email:'admin@gmail.com',phone:'9875689898',gender:'male',state_id: '1', city_id:'2', password:'admin123',password_confirmation:'admin123')
user2.add_role :admin