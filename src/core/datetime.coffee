core = std 'import core'

datetime = Date

datetime::now = () ->
	

datetime::format = (format) ->
	timestamp = @to_timestamp
	
	return core.vendor.strftime(format, timestamp)

datetime::to_timestamp = () ->
	return Math.floor(@getTime() / 1000)

exports.datetime = datetime