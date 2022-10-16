Object = require("lib.classic")
local love = require("love")

--------------------------------------------------------------------------------
--                                   Player                                   --
--------------------------------------------------------------------------------

Player = Object:extend()

function Player:new()
	self.image = love.graphics.newImage("assets/sheep.png")
	self.x = 300
	self.y = 20
	self.speed = 500
	self.width = self.image:getWidth()
end

function Player:update(dt)
	if love.keyboard.isDown("left") then
		self.x = self.x - self.speed * dt
	elseif love.keyboard.isDown("right") then
		self.x = self.x + self.speed * dt
	end

	local window_width = love.graphics.getWidth()

	if self.x < 0 then
		self.x = 0
	elseif self.x + self.width > window_width then
		self.x = window_width - self.width
	end
end

function Player:draw()
	love.graphics.draw(self.image, self.x, self.y)
end

function Player:keyPressed(key, bullets)
	if key == "space" then
		table.insert(bullets, Bullet(self.x, self.y))
	end
end

--------------------------------------------------------------------------------
--                                    Enemy                                   --
--------------------------------------------------------------------------------

Enemy = Object:extend()

function Enemy:new()
	self.image = love.graphics.newImage("assets/sheep.png")
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.x = 325
	self.y = 450
	self.speed = 100
end

function Enemy:update(dt)
	self.x = self.x + self.speed * dt

	local window_width = love.graphics.getWidth()

	if self.x < 0 then
		self.x = 0
		self.speed = -self.speed
	elseif self.x + self.width > window_width then
		self.x = window_width - self.width
		self.speed = -self.speed
	end
end

function Enemy:draw()
	love.graphics.draw(self.image, self.x, self.y)
end

--------------------------------------------------------------------------------
--                                   Bullet                                   --
--------------------------------------------------------------------------------

Bullet = Object:extend()

function Bullet:new(x, y)
	self.image = love.graphics.newImage("assets/bullet.png")
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.x = x
	self.y = y
	self.speed = 700
end

function Bullet:update(dt)
	self.y = self.y + self.speed * dt

	-- bullet is off of the screen
	if self.y > love.graphics.getHeight() then
		-- restart the game
		love.load()
	end
end

function Bullet:draw()
	love.graphics.draw(self.image, self.x, self.y)
end

function Bullet:checkCollision(obj)
	local self_left = self.x
	local self_right = self.x + self.width
	local self_top = self.y
	local self_bottom = self.y + self.height

	local obj_left = obj.x
	local obj_right = obj.x + obj.width
	local obj_top = obj.y
	local obj_bottom = obj.y + obj.height

	if self_right > obj_left and self_left < obj_right and self_bottom > obj_top and self_top < obj_bottom then
		self.dead = true

		if obj.speed > 0 then
			obj.speed = obj.speed + 50
		else
			obj.speed = obj.speed - 50
		end
	end
end

--------------------------------------------------------------------------------
--                                    Main                                    --
--------------------------------------------------------------------------------

local player = nil
local enemy = nil
local bullets = nil

function love.load()
	player = Player()
	enemy = Enemy()
	bullets = {}
end

function love.update(dt)
	player:update(dt)
	enemy:update(dt)

	for i, v in ipairs(bullets) do
		v:update(dt)
		v:checkCollision(enemy)

		if v.dead then
			table.remove(bullets, i)
		end
	end
end

function love.draw()
	player:draw()
	enemy:draw()

	for _, v in ipairs(bullets) do
		v:draw()
	end
end

function love.keypressed(key)
	player:keyPressed(key, bullets)
end
