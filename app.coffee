http = require("http")
fs = require("fs")
url = require("url")
moment = require("moment")
Notification = require('node-notifier')


process.stdout.write "\u001bc"

class FridaySermon
	@globalName

	constructor: (@date = "") ->
		@urlPath =
			base: "http://www.alislam.org/archives/sermons/mp3/"
			prefix: "FSA"
			suffix: "-UR.mp3"


	download: () ->
		console.log "DOWNLOAD: #{@urlToSermon()}"
		
		file = fs.createWriteStream("./Sermons/#{@generateFileName()}")
		request = http.get(@urlToSermon(), (response) ->
				response.pipe file
				return
		)
		@notification()
		

	urlToSermon: ->
		"#{@urlPath.base}#{@urlPath.prefix}#{@getLastFridayDate()}#{@urlPath.suffix}"

	generateFileName: ->
		"#{@urlPath.prefix}#{@getLastFridayDate()}#{@urlPath.suffix}"

	getLastFridayDate: () ->
		lastSermon = moment().day(-2).format("YYYYMMDD")

	getLastFridayDateHumanFormat: () ->
		lastSermon = moment().day(-2).format("DD-MM-YYYY")

	clearConsole: ->
		process.stdout.write "\u001bc"

	filterMp3NameOfUrl: (url="") ->
		regex = /(F.*)$/
		if url.match(regex)
		 	result[1]

 	filterMp3NameByDate: () ->
 		console.log "datum kann uber konstruktur eingegben werden und diese folge wird heruntergeladen"

	notification: () ->
		notifier = new Notification()
		notifier.notify
			title: "Erfolgreich heruntergeladen"
			message: "Khutba vom #{@getLastFridayDateHumanFormat()}"
			sound: "Ping" # case sensitive
			contentImage: __dirname + "img/icon.png"
			# appIcon: __dirname + "/icon.png"
		, (error, response) ->
			console.log response
			return

		 
		

	
FrS = new FridaySermon("asdf")
FrS.download()













# urlPath =
# 	base: "http://www.alislam.org/archives/sermons/mp3/"
# 	prefix: "FSA"
# 	suffix: "-UR.mp3"

# lastSermon = moment().day(-2).format("YYYYMMDD")
# urlStr = "#{urlPath.base}#{urlPath.prefix}#{lastSermon}#{urlPath.suffix}"
# console.log "generated url: #{urlStr}"

# nameOfMp3 = "#{urlPath.prefix}#{lastSermon}#{urlPath.suffix}"

# # Download File
# # file = fs.createWriteStream(nameOfMp3)
# # request = http.get(urlStr, (response) ->
# #   response.pipe file

# #   return
# # )



# console.log "Name of mp3: #{nameOfMp3}"

# console.log "Today: #{moment().format("DD. MM. YYYY")}"
# console.log "calculat friday: #{lastSermon}"
# regex = /(F.*)$/
# result = urlStr.match(regex)
# result[1]
