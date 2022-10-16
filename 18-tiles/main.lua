-- https://sheepolution.com/learn/book/18

local love = require("love")

function love.load()
	--Load the image
	image = love.graphics.newImage("tileset.png")

	--We need the full image width and height for creating the quads
	local image_width = image:getWidth()
	local image_height = image:getHeight()

	width = (image_width / 3) - 2
	height = (image_height / 2) - 2

	--Create the quads
	tile_quads = {}

	for i = 0, 1 do
		for j = 0, 2 do
			table.insert(
				tile_quads,
				love.graphics.newQuad(
					1 + j * (width + 2),
					1 + i * (height + 2),
					width,
					height,
					image_width,
					image_height
				)
			)
		end
	end

	tilemap = {
		{ 1, 6, 6, 2, 1, 6, 6, 2 },
		{ 3, 0, 0, 4, 5, 0, 0, 3 },
		{ 3, 0, 0, 0, 0, 0, 0, 3 },
		{ 4, 2, 0, 0, 0, 0, 1, 5 },
		{ 1, 5, 0, 0, 0, 0, 4, 2 },
		{ 3, 0, 0, 0, 0, 0, 0, 3 },
		{ 3, 0, 0, 1, 2, 0, 0, 3 },
		{ 4, 6, 6, 5, 4, 6, 6, 5 },
	}

	player = {
		image = love.graphics.newImage("player.png"),
		tile_x = 2,
		tile_y = 2,
	}
end

function love.draw()
	for i, row in ipairs(tilemap) do
		for j, tile in ipairs(row) do
			if tile ~= 0 then
				love.graphics.draw(image, tile_quads[tile], j * width, i * height)
			end
		end
	end

	love.graphics.draw(player.image, player.tile_x * width, player.tile_y * height)
end

function love.keypressed(key)
	local x = player.tile_x
	local y = player.tile_y

	if key == "left" then
		x = x - 1
	elseif key == "right" then
		x = x + 1
	elseif key == "up" then
		y = y - 1
	elseif key == "down" then
		y = y + 1
	end

	if tilemap[y][x] == 0 then
		player.tile_x = x
		player.tile_y = y
	end
end
