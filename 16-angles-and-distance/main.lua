love = require("love")

local arrow = {}
local mouse = {}
local distance = nil

function love.load()
	arrow.x = 200
	arrow.y = 200
	arrow.speed = 150
	arrow.angle = 0
	arrow.image = love.graphics.newImage("assets/ghost.png")
	arrow.origin_x = arrow.image:getWidth() / 2
	arrow.origin_y = arrow.image:getHeight() / 2
end

function getDistance(x1, y1, x2, y2)
	local horizontal_distance = x1 - x2
	local vertical_distance = y1 - y2
	--Both of these work
	local a = horizontal_distance * horizontal_distance
	local b = vertical_distance ^ 2

	local c = a + b
	return math.sqrt(c)
end

function love.update(dt)
	mouse.x, mouse.y = love.mouse.getPosition()
	arrow.angle = math.atan2(mouse.y - arrow.y, mouse.x - arrow.x)

	distance = getDistance(arrow.x, arrow.y, mouse.x, mouse.y)

	if distance > 10 then
		local cos = math.cos(arrow.angle)
		local sin = math.sin(arrow.angle)
		arrow.x = arrow.x + arrow.speed * (distance / 100) * cos * dt
		arrow.y = arrow.y + arrow.speed * (distance / 100) * sin * dt
	end
end

function love.draw()
	love.graphics.print("angle: " .. arrow.angle, 10, 10)
	love.graphics.print("distance: " .. distance, 10, 25)

	love.graphics.setColor(255 / 255, 200 / 255, 40 / 255, 127 / 255)
	love.graphics.circle("fill", mouse.x, mouse.y, 2.5)
	love.graphics.line(arrow.x, arrow.y, mouse.x, mouse.y)
	love.graphics.line(arrow.x, arrow.y, mouse.x, arrow.y)
	love.graphics.line(mouse.x, mouse.y, mouse.x, arrow.y)

	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(arrow.image, arrow.x, arrow.y, arrow.angle, 1, 1, arrow.origin_x, arrow.origin_y)
end
