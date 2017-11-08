swiss_club = Club.create(name: "Swiss Club")
Hiker.create(first_name: "Bob", last_name: "Cobb", email: "bob@net.com", club: swiss_club, username: "bobcobb", password_digest: "pass123")
Hiker.create(first_name: "Hal", last_name: "Hope", email: "hal@info.com", club: swiss_club, username: "halhope", password_digest: "pass456")