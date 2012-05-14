# Allows land to join the conversation.
#
# nabes|bodega|tech
#

module.exports = (robot) ->
  robot.hear /land|nabes|bodega|tech/i, (msg) ->
    username = "land_grant"
    msg.http("http://api.twitter.com/1/statuses/user_timeline/#{escape(username)}.json?count=30&include_rts=true")
     .get() (err, res, body) ->
       response = JSON.parse body
       tweet = msg.random response
       if tweet
        msg.send "Howdy neighbor, @land_grant says: '"+tweet.text+"' (http://twitter.com/#!/#{tweet.user.screen_name}/status/#{tweet.id_str})"
       else
        msg.send "Error"