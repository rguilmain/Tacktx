-- The scene base class

local class = require 'third_party.middleclass.middleclass'

local scene = class('scene')

function scene:initialize()
end

function scene:process_mouse_release(x, y, button)

end

function scene:process_mouse_press(x, y, button)

end

function scene:process_key_press(key, is_repeat)

end

return scene
