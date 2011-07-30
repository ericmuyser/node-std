fs = require 'fs'

###
Use to import packages or package contents from the STD.

Usage:
	core = std('import core')
	string = std('import core.string')
	object, string = std('from core import object, string')
	string = std('from core import string')
###
std = (path, use_modules = true) ->
	#console.log path

	###
	for path in std::paths
		do(path) ->
			fs.readFile path, (err, contents) ->
				#compile path, contents.toString()
	###
	success = false
	console.log path
	if use_modules
		for base_path in std::paths
			if path.substr(0, 8) == 'import *'
				return (
					core: require './' + 'core' + '/__init__'
					site: require './' + 'site' + '/__init__'
					blog: require './' + 'blog' + '/__init__'
					debug: require './' + 'debug' + '/__init__'
					framework: require './' + 'framework' + '/__init__'
					database: require './' + 'database' + '/__init__'
				)
			else
				try
					if path.substr(0, 7) == 'import '
						path = path.substr 7
				
					new_path = base_path + path.replace(/\./g, '/') + ''
					
					if new_path.search('std') == 0 # fix browserify
						new_path.replace('std', 'std/lib')
					
					success = require new_path
				catch e
					console.log e
					if !e.message
						throw e
						
					if e.message.replace('std/lib/', './') != "Cannot find module '" + new_path + "'"
						throw e
					
					new_path = base_path + path.replace(/\./g, '/') + '/__init__'
					console.log new_path
					try
						success = require new_path
						
						break
					catch e
						if !e.message
							throw e
						
						if e.message.replace('std/lib/', './') != "Cannot find module '" + new_path + "'"
							throw e
						
						continue
	
	if success == false
		try
			success = require path
		catch e
			throw "Cannot find module: " + path
	debug.info success
	return success
		
std::paths = ['./']

###
Usage:
	std = require('std').std
	std.add_path('./modules')
	std('import my_module')
###
std::add_path = (path) ->
	console.log path
	@paths.push path

###
Use internally because you can't std() within a package's __init__
###
std_import = (path, use_modules = true) ->
	#console.log path
	success = false
	console.log path
	if use_modules
		for base_path in std::paths
			try
				new_path = base_path + path.replace(/\./g, '/') + ''
				
				if new_path.search('std') == 0 # fix browserify
					new_path.replace('std', 'std/lib')
				console.log new_path
				success = require new_path
			catch e
				if !e.message
					throw e
					
				if e.message.replace('std/lib/', './') != "Cannot find module '" + new_path + "'"
					throw e
					
				new_path = base_path + path.replace(/\./g, '/') + '/__init__'
				console.log new_path
				try
					success = require new_path
					
					break
				catch e
					if !e.message
						throw e
					
					if e.message.replace('std/lib/', './') != "Cannot find module '" + new_path + "'"
						throw e
				
					continue
	
	if success == false
		try
			success = require path
		catch e
			throw "Cannot find module: " + path
	debug.info success

	return success

if window?
	master = window
	master['global'] = window
	master['env'] = 'browser'
else if global?
	master = global
	
	jsdom = require 'jsdom'
	
	master['document'] = jsdom.jsdom('<html><head></head><body></body></html>')
	master['window'] = document.createWindow()
	master['jQuery'] = master['$'] = require('jquery').create(window)
	master['env'] = 'node'
	
	window.location.host = 'localhost'
	
	jQuery.ready()
	
	$.isReady = true
	
if !global.debug
	global.debug = {
		info: () ->
	}
	
exports.std = master['std'] = std
exports.std_import = master['std_import'] = std_import