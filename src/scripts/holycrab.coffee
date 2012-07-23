# Returns random crab
#
# reaction <tagname>   - Hit reaction gifs for tag name and return random gif

module.exports = (robot) ->
  robot.hear /holy crab/i, (msg) ->
    reactionMe msg, (url) ->
      msg.send url

reactionMe = (msg, cb) ->
  #properquery = query.replace /\s/g, "-"
  pageNum = Math.floor(Math.random() * 5) + 1;
  #properquery = properquery.replace /[\W^-]/g, ""

  console.log("Page: "+pageNum)
  msg.http('http://animated-gifs.org/animals/crabs/')
    .query(page: pageNum)
    .get() (err, res, body) ->
      gifs = body.match(/http:\/\/animated-gifs\.org\/wp-content\/theme[^"]*\.gif/g)
      if gifs
        gifs = gifs.filter((gif) -> return gif.indexOf("http://animated-gifs.org'") == -1)
        if (gifs.length > 0)
          cb gifs[Math.floor(Math.random() * gifs.length)]
      else
        cb "Sorry, found no reactions for '#{query}'"
      
#      cb body.match(/http:\/\/www.reactiongifs.com[^"]*\.gif/)[1] || "Sorry, found no reaction gifs for '#{query}'"