-- https://sheepolution.com/learn/book/19

local state = {}

function love.load()
	local song = love.audio.newSource("assets/song.ogg", "stream")
	song:setLooping(true)
	song:play()

	state.sfx = love.audio.newSource("assets/sfx.ogg", "static")
end

function love.keypressed(key)
	if key == "space" then
		state.sfx:play()
	end
end
