olivia = User.create(name: "Olivia", email: "olivia@olivia.com", password: "password")
zach = User.create(name: "Zach", email: "zach@zach.com", password: "password")

louis = Dependent.create(name: "Louis", user_id: olivia.id)
owen = Dependent.create(name: "Owen", user_id: zach.id)
eva = Dependent.create(name: "Eva", user_id: olivia.id)

hockey = Activity.create(title: "hockey", contact_name: "coach", contact_phone: "coach phone", website: "website", notes: "notes", dependent_id: owen.id)
soccer = Activity.create(title: "soccer", contact_name: "coach", contact_phone: "coach phone", website: "website", notes: "notes", dependent_id: louis.id)
lacrosse = Activity.create(title: "lacrosse", contact_name: "coach", contact_phone: "coach phone", website: "website", notes: "notes", dependent_id: eva.id)