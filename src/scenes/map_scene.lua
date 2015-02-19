-- The map scene

local class = require 'third_party.middleclass.middleclass'
local scene = require 'scenes.scene'

local map_scene = class('map_scene', scene)

function map_scene:initialize(manager)
  scene.initialize(self)
  self.manager = manager
  self.map = require 'assets.maps.middle_earth'
  self.camera = require 'camera'

  self.x_left = 0
  self.y_left = 0
  self.left_button_clicked = false

  self.x_right = 0
  self.y_right = 0
  self.right_button_clicked = false
end

function map_scene:set_map(map)
  self.map = map
end

function map_scene:draw()
  self.camera:set()
  love.graphics.setColor(255, 255, 255, 255)
  self.map:draw()
  if left_button_clicked then
    love.graphics.setColor(0, 0, 255, 200)
    love.graphics.circle("fill", x_left, y_left, 20, 20)
  end
  if right_button_clicked then
    love.graphics.setColor(255, 0, 0, 200)
    love.graphics.circle("fill", x_right, y_right, 20, 20)
  end
  self.camera:unset()
end

function map_scene:process_mouse_release(x, y, button)
  -- convert our click to world coordinates and calculate tile index
  wx, wy = self.camera:cursorToWorld(x, y)
  row, col = self.map:getTileIndexFromPoint(wx, wy)
  print("At: " .. row .. ", " .. col)

  if button == 'l' then
    x_left, y_left = self.map:getTileCenterFromIndex(row, col)
    left_button_clicked = true
    right_button_clicked = false
  elseif button == 'r' then
    if not left_button_clicked then
      return
    end
    x_right, y_right = self.map:getTileCenterFromIndex(row, col)
    right_button_clicked = true
  end
end

function map_scene:process_mouse_press(x, y, button)
  if button == "wu" then
    -- zoom into the world
    camera:scale(1.1)
  elseif button == "wd" then
    -- zoom out of the world
    camera:scale(0.9)
  end
end

function map_scene:process_key_press(key, is_repeat)
  -- TODO: Combine with love.keyreleased to implement diagonal scrolling
  translate_amount = 20
  if key == 'up' then
     self.camera:move(0, -translate_amount)
  elseif key == 'down' then
     self.camera:move(0, translate_amount)
  elseif key == 'left' then
     self.camera:move(-translate_amount, 0)
  elseif key == 'right' then
     self.camera:move(translate_amount, 0)
  end
end

return map_scene
