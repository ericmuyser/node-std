core = std 'core' 

base = core.mixin core.base

class person extends base
	constructor: (options) ->
		$.extend(@, options)

	name: null
	birthday: null
	address: null
	country: null
	gender: null
	
exports.person = person