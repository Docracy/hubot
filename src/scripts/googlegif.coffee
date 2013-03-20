# Returns random reaction gif for a query
#
# reaction <tagname>   - Hit reaction gifs for tag name and return random gif

module.exports = (robot) ->
  robot.respond /(gif)( me)? (.*)/i, (msg) ->
    reactionMe msg, msg.match[3], (url) ->
      msg.send url

reactionMe = (msg, query, cb) ->
  properquery = query.replace /\s/g, "-"
  #properquery = properquery.replace /[\W^-]/g, ""

  url = 'https://www.google.com/search?hl=en&site=&tbm=isch&source=hp&biw=1413&bih=1024&tbs=itp:animated&q='+properquery
  console.log("Querying: "+url)
  msg.http(url)
    .get() (err, res, body) ->
      gifs = body.match(/(imgurl=http:[^"]*?\.gif)/g)
      console.log("  Results: "+body.length)
      if gifs
        gifs = gifs.filter((gif) -> return gif.indexOf("loading.gif") == -1)
        gifs = gifs.filter((gif) -> return gif.indexOf("thumbs") == -1)
        if (gifs.length > 0)
          gifUrl = gifs[Math.floor(Math.random() * gifs.length)]
          gifUrl = gifUrl.replace('imgurl=','')
          cb gifUrl
      else
        cb "Sorry, found no reactions for '#{query}'"
      
#      cb body.match(/http:\/\/www.reactiongifs.com[^"]*\.gif/)[1] || "Sorry, found no reaction gifs for '#{query}'"