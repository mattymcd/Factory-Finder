require "faker"

users = [
  { name: "Steve Jobs",
    username: "sjobs",
    email: "sjobs@apple.com",
    password: "12345",
  },
  { name: "Bill Gates",
    username: "bgates",
    email: "bgates@microsoft.com",
    password: "12345",
  },
  { name: "Sofie Garden",
    username: "sgarden",
    email: "sgarden@devbootcamp.com",
    password: "12345",
  },
  { name: "Dixon Adair",
    username: "dadair",
    email: "dadair@devbootcamp.com",
    password: "12345",
  },
  { name: "Matt McDole",
    username: "mmdole",
    email: "mmdole@devbootcamp.com",
    password: "12345",
  },
  { name: "Marko Potocnik",
    username: "mpotocnik",
    email: "mpotocnik@devbootcamp.com",
    password: "12345",
  },
]

users.each do |user|
  User.create(name: user[:name],
              username: user[:username],
              email: user[:email],
              password: user[:password])
end

# Create Relationships

5.times do |counter|
  Relationship.create(fan_id: User.find(counter + 2).id, idol_id: User.find(counter + 1).id )
end

30.times do
  User.find(rand(1..6)).tweets.create(content: Faker::Lorem.sentence)
end
