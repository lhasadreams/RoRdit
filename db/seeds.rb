require 'open-uri'
require 'json'
require 'faker'

puts "Starting to create site settings"
puts "-------------------------------"

SiteSetting.create(title: "RoRdit", slogan: "Slogan is here.")

puts "-------------------------------"
puts "Finished to create stite settings"

puts "Starting to create 1 admin user"
puts "-------------------------------"

AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

puts "-------------------------------"
puts "Finished to create 1 admin user"

puts "\nStarting to create 50 users"
puts "-------------------------------"

50.times do
  User.create(username: Faker::Name.unique.name, email: Faker::Internet.unique.email, password: "123456")
end

puts "Finished to create 50 users"

puts "\nStarting to create 50 links from Hacker News (it takes time)"
puts "-------------------------------"

response = open('https://hacker-news.firebaseio.com/v0/topstories.json').read
top_500_ids = JSON.parse(response)

top_500_ids.each do |id|
  break if Link.count >= 50

  begin
    Timeout.timeout(3) do
      story_response = open("https://hacker-news.firebaseio.com/v0/item/#{id}.json").read
      story = JSON.parse(story_response)
      user = User.order("RANDOM()").first
      Link.create!(title: story["title"], url: story["url"], user_id: user.id, username: user.username,
                      hostname: URI.parse(story["url"]).hostname.sub(/^www\./, ''))
    end
  rescue Timeout::Error => e
    puts "Timeout | Error: #{e}"
  rescue => e
    puts "Error: #{e}"
  end
end

puts "Finished to create 50 links"

puts "\nStarting to create 100 comments"
puts "-------------------------------"

100.times do
  text = Faker::Lorem.paragraph(2)
  user = User.order("RANDOM()").first
  link = Link.order("RANDOM()").first
  Comment.create(comment: text, user_id: user.id, link_id: link.id, username: user.username)
end

puts "Finished to create 100 comments"

puts "\nStarting to create 100 points for links"
puts "-------------------------------"

100.times do
  user = User.order("RANDOM()").first
  link = Link.order("RANDOM()").first
  Point.create(user_id: user.id, link_id: link.id)
end

puts "Finished to create 100 points for links"

puts "\nStarting to create 100 points for comments"
puts "-------------------------------"

100.times do
  user = User.order("RANDOM()").first
  comment = Comment.order("RANDOM()").first
  Point.create(user_id: user.id, comment_id: comment.id)
end

puts "Finished to create 100 point for links"

puts "Starting to calculate popularity of links"

Link.calculate_popularity

puts "Finished to calculate popularity of links"
