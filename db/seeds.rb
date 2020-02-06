# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!([{ email: "admin1@email.com", password: "123456", role: "admin"},
{ email: "user1@email.com", password: "654321", role: "user"}, { email: "editor1@email.com", password: "123456", role: "editor"}])

tags = Tag.create!([{name: "Tag 1", status: "published"}, {name: "Tag 1", status: "draft"}])

articles = Article.create!([{title: "Titre d'article", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse et purus vel odio posuere dictum nec non justo. Maecenas posuere leo dolor, pharetra faucibus odio viverra sagittis. Aenean nec elit odio. Nulla non orci velit. Nulla facilisi. Aenean tempor turpis vitae enim porta, a egestas libero fermentum. Pellentesque volutpat nec ligula vel fringilla. Fusce sed ante non ligula venenatis dapibus. Sed odio leo, auctor id ornare vitae, mollis dictum augue. Sed sed interdum elit, quis viverra lorem.", status: "published", source_name: "source", user_id: "1"},
{title: "Article draft", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse et purus vel odio posuere dictum nec non justo. Maecenas posuere leo dolor, pharetra faucibus odio viverra sagittis. Aenean nec elit odio. Nulla non orci velit. Nulla facilisi. Aenean tempor turpis vitae enim porta, a egestas libero fermentum. Pellentesque volutpat nec ligula vel fringilla. Fusce sed ante non ligula venenatis dapibus. Sed odio leo, auctor id ornare vitae, mollis dictum augue. Sed sed interdum elit, quis viverra lorem.", status: "draft", source_name: "source 2", user_id: "1"}])
