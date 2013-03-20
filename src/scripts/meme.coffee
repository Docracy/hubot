# A way to generate memes via our friends at memecaptain.com - https://github.com/mmb/meme_captain
#
# meme me <image query>,<top line>,<bottom line> - Make a quality meme

module.exports = (robot) ->
  robot.respond /(meme)( me)? ([^,]*),([^,]*)(,([^,]*))?/i, (msg) ->
    for match in msg.match
      console.log match
    imageMe msg, msg.match[3], (url) ->
      if msg.match[5]
        lastMatch = msg.match[5].replace /,/g, ""
        memeUrl = "http://v1.memecaptain.com/g?u="+encodeURIComponent(url)+"&t1="+encodeURIComponent(msg.match[4])+"&t2="+encodeURIComponent(lastMatch)
      else
        memeUrl = "http://v1.memecaptain.com/g?u="+encodeURIComponent(url)+"&t1="+encodeURIComponent(msg.match[4])
      console.log("Sending request to memcaptain: "+memeUrl)
      msg.http(memeUrl)
        .get() (err, res, body) ->
          console.log('Meme captain result: '+body)
          result = JSON.parse(body)
          msg.send result.imageUrl

imageMe = (msg, query, cb) ->
  if query.indexOf('http') == 0
    cb query
    return
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(v: "1.0", rsz: '8', q: query, safe: 'active')
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.responseData.results
      if images.length > 0
        # image  = msg.random images
        image = images[0]
        cb "#{image.unescapedUrl}#.png"

