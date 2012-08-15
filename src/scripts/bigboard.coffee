# Show the active user stats for this week on Docracy
#
# radar - Show the loop

quotes = [
  "Behold, the instrument of your liberation!",
  "It doesn't matter who we are... what matters is our plan.",
  "Now's not the time for fear. That comes later.",
  "Theatricality and deception, powerful agents for the uninitiated."
  ]


module.exports = (robot) ->
  robot.respond /(bigboard|board|baneboard)( me)?/i, (msg) ->
  	bigBoardURL = process.env.BIGBOARD_URL
  	console.log("BIGBOARD_URL: " + bigBoardURL)
  	msg.http(bigBoardURL)
	  	.get() (err, res, body) ->
	  		if (msg.match[0].indexOf('bane') != -1)
	  			msg.send quotes[Math.floor(Math.random() * quotes.length)]+"\n" + body
	  		else
	  			msg.send body