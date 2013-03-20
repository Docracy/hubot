# Allows land to join the conversation.
#
# nabes|bodega|tech
#

module.exports = (robot) ->
  robot.respond /(landmine)/i, (msg) ->
    for num in[1..5]
      landMe msg, (url) ->
        msg.send url

  robot.hear /land|nabes|bodega|tech/i, (msg) ->
    landMe msg, (url) ->
      msg.send url

landMe = (msg, cb) ->
    username = "land_grant"
    msg.http("http://api.twitter.com/1/statuses/user_timeline/#{escape(username)}.json?count=30&include_rts=true")
     .get() (err, res, body) ->
       response = JSON.parse body
       tweet = msg.random response
       if tweet
        cb "http://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id_str}"
       else
        cb "Error"