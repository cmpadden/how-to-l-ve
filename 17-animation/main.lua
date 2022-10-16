-- https://sheepolution.com/learn/book/17

local love = require("love")

local currentFrame = nil
local frames = nil
local image = nil

function love.load()
	image = love.graphics.newImage("jump.png")
	local width = image:getWidth()
	local height = image:getHeight()

	frames = {}

	local frame_width = 117
	local frame_height = 233

	for i = 0, 1 do
		--I changed i to j in the inner for-loop
		for j = 0, 2 do
			--Meaning you also need to change it here
			table.insert(
				frames,
				love.graphics.newQuad(
					1 + j * (frame_width + 2),
					1 + i * (frame_height + 2),
					frame_width,
					frame_height,
					width,
					height
				)
			)
		end
	end

	currentFrame = 1
end

function love.draw()
	love.graphics.draw(image, frames[math.floor(currentFrame)], 100, 100)
end

function love.update(dt)
	currentFrame = currentFrame + 10 * dt
	if currentFrame >= 6 then
		currentFrame = 1
	end
end
