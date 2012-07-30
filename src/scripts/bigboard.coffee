# Show the active user stats for this week on Docracy
#
# radar - Show the loop

module.exports = (robot) ->

  robot.respond /(bigboard|board)( me)?/i, (msg) ->
  	bigBoardURL = process.env.BIGBOARD_URL
  	console.log("BIGBOARD_URL: " + bigBoardURL)
  	msg.http(bigBoardURL)
	  	.get() (err, res, body) ->
	    	msg.send body