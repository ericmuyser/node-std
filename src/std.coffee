if(!console?)
	console =
		log: () ->
	
	debug = 
		info: () ->
			

###
Use to import packages or package contents from the STD.

Usage:
	core = std('import core')
	string = std('import core.string')
	object, string = std('from core import object, string')
	string = std('from core import string')
###
std = (path, use_modules = true) ->
	fs = require('fs')
	
	###
	for path in std::paths
		do(path) ->
			fs.readFile path, (err, contents) ->
				#compile path, contents.toString()
	###
	if path.substr(0, 8) == 'import *'
		return (
			core: require('./' + 'core' + '/__init__.js')
			site: require('./' + 'site' + '/__init__.js')
			blog: require('./' + 'blog' + '/__init__.js')
			framework: require('./' + 'framework' + '/__init__.js')
			database: require('./' + 'database' + '/__init__.js')
		)
	else
		if(use_modules)
			try
				if(path.substr(0, 7) == 'import ')
					path = path.substr(7)
			
				new_path = './' + path.replace(/\./g, '/') + '.js'
				console.log 1, new_path
				return require(new_path)
			catch e
				if e.message.substr(0, 'Cannot find module'.length) != 'Cannot find module'
					throw e
				
				new_path = './' + path.replace(/\./g, '/') + '/__init__.js'
				console.log 2, new_path
				return require(new_path)
	
		console.log('./' + 'framework' + '/__init__.js')
		
		return require(path)

		
std::paths = []

###
Usage:
	std = require('std').std
	std.add_path('./modules')
	std('import my_module')
###
std::add_path = (path) ->
	@paths = path


###
Use internally because you can't std() within a package's __init__
###
std_import = (path, use_modules = true) ->
	fs = require('fs')

	if(use_modules)
		try
			new_path = './' + path.replace(/\./g, '/') + '.js'
			console.log 3, new_path
			return require(new_path)
		catch e
			if e.message.substr(0, 'Cannot find module'.length) != 'Cannot find module'
				throw e
				
			new_path = './' + path.replace(/\./g, '/') + '/__init__.js'
			console.log 4, new_path
			return require(new_path)

		return require(path)

if global?
	master = global
else if window?
	master = window

exports.std = master['std'] = std
exports.std_require = exports.std_import = master['std_import'] = master['std_require'] = std_import