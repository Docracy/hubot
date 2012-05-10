# Clear screen with unsee gifs
#
# unseebomb   - Return enough unsee gifs to clear the screen

module.exports = (robot) ->
  robot.respond /(unseebomb)/i, (msg) ->
    reactionMe msg, "unsee", (url) ->
      msg.send url for num in [1..5]

reactionMe = (msg, query, cb) ->
  msg.http('http://www.reactiongifs.com/')
    .query(tag: query)
    .get() (err, res, body) ->
      gifs = body.match(/http[^"]*\.gif/g)
      if gifs
        cb gifs[Math.floor(Math.random() * gifs.length)]
      else
        cb "Sorry, found no reactions for '#{query}'"
      
#      cb body.match(/http:\/\/www.reactiongifs.com[^"]*\.gif/)[1] || "Sorry, found no reaction gifs for '#{query}'"