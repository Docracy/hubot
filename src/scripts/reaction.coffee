# Returns random reaction gif for a query
#
# reaction <tagname>   - Hit reaction gifs for tag name and return random gif

module.exports = (robot) ->
  robot.respond /(reaction)( me)? (.*)/i, (msg) ->
    reactionMe msg, msg.match[3], (url) ->
      msg.send url

reactionMe = (msg, query, cb) ->
  properquery = query.replace /\s/g, "-"
  #properquery = properquery.replace /[\W^-]/g, ""

  console.log("Querying: "+properquery)
  msg.http('http://www.reactiongifs.com/')
    .query(tag: properquery)
    .get() (err, res, body) ->
      gifs = body.match(/http[^"]*\.gif/g)
      if gifs
        gifs = gifs.filter((gif) -> return gif.indexOf("loading.gif") == -1)
        if (gifs.length > 0)
          cb gifs[Math.floor(Math.random() * gifs.length)]
      else
        cb "Sorry, found no reactions for '#{query}'"
      
#      cb body.match(/http:\/\/www.reactiongifs.com[^"]*\.gif/)[1] || "Sorry, found no reaction gifs for '#{query}'"