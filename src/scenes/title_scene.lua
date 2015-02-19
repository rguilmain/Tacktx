-- The title screen for Tacktx

local class = require 'third_party.middleclass.middleclass'
local scene = require 'scenes.scene'

local title_scene = class('title_scene', scene)

function title_scene:initialize(manager)
  scene.initialize(self)
  self.manager = manager
  self.start_button_width = 50
  self.start_button_height = 20
end

function title_scene:draw()
  width, height = love.graphics.getDimensions()

  love.graphics.setColor(200, 15, 15, 255)
  love.graphics.print("Tacktx!", width/2, height*1/4, 0, 2, 2)

  b_x = (width - self.start_button_width)/2
  b_y = (height - self.start_button_height)/2

  love.graphics.setColor(30, 45, 180, 255)
  love.graphics.rectangle("fill", b_x, b_y,
                          self.start_button_width, self.start_button_height)
end

function title_scene:process_mouse_press(x, y, button)
  if x > b_x and x < b_x + self.start_button_width and
     y > b_y and y < b_y + self.start_button_height then
    self.manager:set_scene('map')
  end
end

return title_scene
