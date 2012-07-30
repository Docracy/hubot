# A way to generate memes via our friends at memecaptain.com - https://github.com/mmb/meme_captain
#
# meme me <image query>,<top line>,<bottom line> - Make a quality meme

module.exports = (robot) ->
  robot.respond /(meme)( me)? ([\w\s]*),([\w\s]*)(,([\w\s]*))?/i, (msg) ->
    for match in msg.match
      console.log match
    imageMe msg, msg.match[3], (url) ->
      if msg.match[5]
        lastMatch = msg.match[5].replace /,/g, ""
        memeUrl = "http://memecaptain.com/i?u="+escape(url)+"&t1="+escape(msg.match[4])+"&t2="+escape(lastMatch)
      else
        memeUrl = "http://memecaptain.com/i?u="+escape(url)+"&t1="+escape(msg.match[4])
      msg.send memeUrl

imageMe = (msg, query, cb) ->
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(v: "1.0", rsz: '8', q: query, safe: 'active')
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.responseData.results
      if images.length > 0
        # image  = msg.random images
        image = images[0]
        cb "#{image.unescapedUrl}#.png"

