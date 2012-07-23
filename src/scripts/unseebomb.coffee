# Clear screen with unsee gifs
#
# unseebomb   - Return enough unsee gifs to clear the screen

module.exports = (robot) ->
  robot.respond /(unseebomb)/i, (msg) ->
    msg.send "http://www.reactiongifs.com/wp-content/uploads/2012/04/unsee.gif" for num in [1..5]