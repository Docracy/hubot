# Show the northeast weather radar loop
#
# radar - Show the loop

module.exports = (robot) ->

  robot.respond /(radar)( me)?/i, (msg) ->
    msg.send "http://radar.weather.gov/Conus/Loop/northeast_loop.gif"