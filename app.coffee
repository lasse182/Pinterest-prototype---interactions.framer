# Intro screen

## constants
BOARDS_URL = 'https://api.pinterest.com/v1/me/boards/?access_token=AYr0WrC1RuYEZoIqoF82vaqUXo6cFOq8RSwQtvxEXzFhHoBBiwAAAAA&fields=id%2Cname%2Curl'

boards = []

dataMessage = () =>
	dataMessage = new TextLayer
		parent: introScreen
		text: "Data fetched from Pinterest :)"
		fontSize: 14
		color: "black"
		x: Align.center()
		y: Align.bottom(-30)

request = (url, callback) =>
	r = new XMLHttpRequest
	r.open 'GET', url, true
	r.responseType = 'json'
	r.onreadystatechange = ->
		if(r.status >= 400)
			print "Error #{r.status}"
		if(r.readyState == XMLHttpRequest.DONE && r.status == 200)
			callback(r.response)
	r.send()

getBoards = (callback) =>
	request(BOARDS_URL, (data) =>
		if data
			boards = data.data
			callback()
		else
			"No data for you my friend.."
	)

getBoards(dataMessage)

# Create layers
introScreen = new Layer
	size: Screen.size
	backgroundColor: "#fff"

sidebarScreen = new Layer
	size: Screen.size
	backgroundColor: "#fff"

dropzoneScreen = new Layer
	size: Screen.size
	backgroundColor: "#fff"

buttonSidebar = new TextLayer
	parent: introScreen
	text: "Sidebar"
	color: "#fff"
	backgroundColor: "blue"
	borderRadius: 4
	fontSize: 32
	textTransform: "uppercase"
	fontWeight: "bold"
	padding:
		top: 5
		bottom: 5
		left: 10
		right: 10
	x: Align.center()
	y: Align.center(-80)

buttonDropzone = new TextLayer
	parent: introScreen
	text: "Dropzone"
	color: "#fff"
	backgroundColor: "red"
	borderRadius: 4
	fontSize: 32
	textTransform: "uppercase"
	fontWeight: "bold"
	padding:
		top: 5
		bottom: 5
		left: 10
		right: 10
	x: Align.center()
	y: Align.center(80)

buttonBottombar = new TextLayer
	parent: introScreen
	text: "Bottombar"
	color: "#fff"
	backgroundColor: "LIMEGREEN"
	borderRadius: 4
	fontSize: 32
	textTransform: "uppercase"
	fontWeight: "bold"
	padding:
		top: 5
		bottom: 5
		left: 10
		right: 10
	x: Align.center()
	y: Align.center()

# Set up FlowComponent
flow = new FlowComponent
flow.showNext(introScreen)

# Switch on click
buttonSidebar.onClick ->
	flow.showNext(sidebarScreen)

buttonDropzone.onClick ->
	flow.showNext(dropzoneScreen)
	
## Sidebar screen

# Back button
backButton = new TextLayer
	parent: sidebarScreen
	text: "Back"
	color: "#fff"
	backgroundColor: "DARKSLATEGRAY"
	borderRadius: 4
	fontSize: 14
	textTransform: "uppercase"
	fontWeight: "bold"
	padding:
		top: 5
		bottom: 5
		left: 10
		right: 10
	x: Align.left(20)
	y: Align.top(20)

backButton.onClick ->
	flow.showPrevious()

# Sidebar
sidebar = new Layer
	parent: sidebarScreen
	width: 600
	height: Canvas.frame.height
	x: Align.right(600)
	backgroundColor: "#ffffff"
	shadowColor: "#e2e2e2"
	shadowY: 5
	shadowBlur: 10
	shadowSpread: 5

# Image
image = new Layer
	parent: sidebarScreen
	width: 200
	height: 200
	x: 150
	y: Align.center
	image: "images/avatar-10.png"

# Add drag capabilities
image.draggable.enabled = true
image.draggable.constraints = 
	x: image.x
	y: image.y

image.draggable.overdragScale = 1

image.onDragStart ->
	sidebar.animate
		x: Align.right
		options:
			time: 0.5

image.onDragEnd ->
	sidebar.animate
		x: Align.right(600)
		options:
			time: 0.5

renderItems = () =>
	y = 20
	for board, i in boards
		sidebarItem = new Layer
			parent: sidebar
			height: 50
			backgroundColor: "#f9f9f9"
			shadowColor: "e2e2e2"
			y: y
		
		sidebarItemText = new TextLayer
			text: board.name
			parent: sidebarItem
			color: "#555"
			fontSize: 14
			fontWeight: "bold"
			y: Align.center
			x: 20
			
		
		sidebarItem.width = 270
		sidebarItem.x = 20
		
		y = y+sidebarItem.height+10
		
		if i > 15
			sidebarItem.x = 310
		
		if i == 15
			y = 20

getBoards(renderItems)


# Back button
backButton = new TextLayer
	parent: dropzoneScreen
	text: "Back"
	color: "#fff"
	backgroundColor: "DARKSLATEGRAY"
	borderRadius: 4
	fontSize: 14
	textTransform: "uppercase"
	fontWeight: "bold"
	padding:
		top: 5
		bottom: 5
		left: 10
		right: 10
	x: Align.left(20)
	y: Align.top(20)

backButton.onClick ->
	flow.showPrevious()

# Image
image = new Layer
	parent: dropzoneScreen
	width: 200
	height: 200
	x: 150
	y: Align.center
	image: "images/avatar-10.png"

# Add drag capabilities
image.draggable.enabled = true
image.draggable.constraints = 
	x: image.x
	y: image.y

image.draggable.overdragScale = 1

image.onDragStart ->

image.onDragEnd ->
