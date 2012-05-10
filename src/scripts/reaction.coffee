# Returns random reaction gif for a query
#
# reaction <tagname>   - Hit reaction gifs for tag name and return random gif

module.exports = (robot) ->
  robot.respond /(reaction)( me)? (.*)/i, (msg) ->
    reactionMe msg, msg.match[3], (url) ->
      msg.send url

reactionMe = (msg, query, cb) ->
  msg.http('http://www.reactiongifs.com/')
    .query(tag: query)
    .get() (err, res, body) ->
      gifs = body.match(/http[^"]*\.gif/g)
      if gifs
        cb gifs[Math.floor(Math.random() * gifs.length)]
      else
        cb "Sorry, found no reactions for '#{query}'"
      
#      cb [1] || "Sorry, found no reaction gifs for '#{query}'"
#      cb body.match(/http:\/\/www.reactiongifs.com[^"]*\.gif/)[1] || "Sorry, found no reaction gifs for '#{query}'"