# Show the active user stats for this week on Docracy
#
# radar - Show the loop

module.exports = (robot) ->

  robot.respond /(bigboard|board)( me)?/i, (msg) ->
  	msg.http('https://localhost:9443/application/activestats')
	  	.get() (err, res, body) ->
	    	msg.send body