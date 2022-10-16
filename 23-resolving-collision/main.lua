-- https://sheepolution.com/learn/book/23

function love.load()
	-- First require classic, since we use it to create our classes.
	Object = require("classic")
	-- Second require Entity, since it's the base class for our other classes.
	require("entity")
	require("player")
	require("wall")
	require("box")

	wall = Wall(100, 100)
	box1 = Box(200, 105)
	box2 = Box(275, 110)
	box3 = Box(350, 115)
	player = Player(450, 100)

	objects = {}
	table.insert(objects, player)
	table.insert(objects, wall)
	table.insert(objects, box1)
	table.insert(objects, box2)
	table.insert(objects, box3)
end

function love.update(dt)
	-- Update all the objects
	for i, v in ipairs(objects) do
		v:update(dt)
	end

	local loop = true
	local limit = 0

	while loop do
		-- Set loop to false, if no collision happened it will stay false
		loop = false

		limit = limit + 1
		if limit > 100 then
			-- Still not done at loop 100
			-- Break it because we're probably stuck in an endless loop.
			break
		end

		for i = 1, #objects - 1 do
			for j = i + 1, #objects do
				local collision = objects[i]:resolveCollision(objects[j])
				if collision then
					loop = true
				end
			end
		end
	end
end

function love.draw()
	-- Draw all the objects
	for i, v in ipairs(objects) do
		v:draw()
	end
end
