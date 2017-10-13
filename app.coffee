## constants
BOARDS_URL = 'https://api.pinterest.com/v1/me/boards/?access_token=AYr0WrC1RuYEZoIqoF82vaqUXo6cFOq8RSwQtvxEXzFhHoBBiwAAAAA&fields=id%2Cname%2Curl'

boards = []

# Sidebar
sidebar = new Layer
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

getBoards = () =>
	request(BOARDS_URL, (data) =>
		if data
			boards = data.data
			renderItems()
		else
			"No data for you my friend.."
	)

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

getBoards()