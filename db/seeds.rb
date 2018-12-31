# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'Admin', email: 'admin@gmail.com', password: '1111aQ', access: true)
AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
Product.create(title: 'Product1', price: 1,
               short_description: 'Lorem ipsum dolor sit amet, doming putent interpretaris sit te.',
               full_description: 'Lorem ipsum dolor sit amet, doming putent interpretaris sit te.',
               in_stock: true, category_id: 1)
Category.create(title: 'first')