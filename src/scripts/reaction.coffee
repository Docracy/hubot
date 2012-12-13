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

  url = 'http://www.reactiongifs.com/tag/'+properquery+"/"
  console.log("Querying: "+url)
  msg.http(url)
    .get() (err, res, body) ->
      gifs = body.match(/(http:[^"]*?\.gif)/g)
      console.log("  Results: "+body.length)
      if gifs
        gifs = gifs.filter((gif) -> return gif.indexOf("loading.gif") == -1)
        gifs = gifs.filter((gif) -> return gif.indexOf("thumbs") == -1)
        if (gifs.length > 0)
          cb gifs[Math.floor(Math.random() * gifs.length)]
      else
        cb "Sorry, found no reactions for '#{query}'"
      
#      cb body.match(/http:\/\/www.reactiongifs.com[^"]*\.gif/)[1] || "Sorry, found no reaction gifs for '#{query}'"