olivia = User.create(name: "Olivia", email: "olivia@olivia.com", password: "password")
zach = User.create(name: "Zach", email: "zach@zach.com", password: "password")

Dependent.create(name: "Louis", user_id: olivia.id)
Dependent.create(name: "Owen", user_id: zach.id)
Dependent.create(name: "Eva", user_id: olivia.id)
