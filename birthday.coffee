module.exports = (robot) ->

  robot.respond /birthday (.*) (.*) add$/i, (msg) ->
    dateArr = msg.match[2].split("/");
    day = dateArr[0]
    month = dateArr[1] - 1
    year  = dateArr[2]

    bdDate = new Date(year, month, day)
    birthday =
      user: msg.match[1]
      date: bdDate
      parsedDate: bdDate.toLocaleDateString();

    robot.brain.data.birthdays      ?= []
    robot.brain.data.birthday_users ?= []

    if birthday.user in robot.brain.data.birthday_users
      msg.send "I already got #{birthday.user}'s birthday on my calendar."
    else
      robot.brain.data.birthdays.push birthday
      robot.brain.data.birthday_users.push birthday.user
      msg.send "Got it. #{birthday.user}'s birthday is on #{birthday.parsedDate}"

  robot.respond /birthday (.*) (.*) change$/i, (msg) ->
    birthday =
      user: msg.match[1]
      date: msg.match[2]

    robot.brain.data.birthdays      ?= []


  robot.respond /birthdays$/i, (msg) ->
    robot.brain.data.birthdays      ?= []
    for bd in robot.brain.data.birthdays
      bd.date.setFullYear(new Date().getFullYear());
      msg.send "#{bd.user}: #{bd.date.toLocaleDateString()}"