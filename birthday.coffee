module.exports = (robot) ->

  robot.respond /birthday (.*) (.*) add$/i, (msg) ->
    birthday =
      user: msg.match[1]
      date: msg.match[2]
    
    robot.brain.data.birthdays      ?= []
    robot.brain.data.birthday_users ?= []
    
    if birthday.user in robot.brain.data.birthday_users
      msg.send "I already got #{birthday.user}'s birthday on my calendar."
    else
      robot.brain.data.birthdays.push birthday
      robot.brain.data.birthday_users.push birthday.user
      msg.send "Got it. #{birthday.user}'s birthday is on #{birthday.date}"

  robot.respond /birthday (.*) (.*) change$/i, (msg) ->
    birthday =
      user: msg.match[1]
      date: msg.match[2]
      
    robot.brain.data.birthdays      ?= []  
    msg.send robot.brain.data.birthdays