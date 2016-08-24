# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.create([
    {
        email: 'rayn1027@outlook.com',
        name: '彭潇',
        nickname: 'Rayn',
        gender: true,
        password: '123456'
    },
    {
        email: 'rayn1027@outlook.com',
        name: '文欣',
        nickname: 'Chobi15',
        gender: true,
        password: '123456'
    },
    {
        email: 'rayn1027@outlook.com',
        name: '黄坤',
        nickname: 'Calmeii',
        gender: true,
        password: '123456'
    }
])