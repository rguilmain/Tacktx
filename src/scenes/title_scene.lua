-- The title screen for Tacktx

local class = require 'third_party.middleclass.middleclass'
local scene = require 'scenes.scene'

local title_scene = class('title_scene', scene)

function title_scene:initialize(manager)
  scene.initialize(self)
  self.manager = manager
  self.button_width = 150
  self.button_height = 36
  self.start_button_x = 0
  self.start_button_y = 0
  self.credits_button_x = 0
  self.credits_button_y = 0
  self.title_font = love.graphics.newFont(32)
  self.menu_font = love.graphics.newFont(24)
  self.menu_state = 'title'
end

function title_scene:draw()
  if self.menu_state == 'title' then
    self:draw_title()
  elseif self.menu_state == 'credits' then
    self:draw_credits()
  else
    print('Warning: Unknown title menu state.')
  end
end

function title_scene:draw_title()
  width, height = love.graphics.getDimensions()
  love.graphics.setBackgroundColor(0, 0, 70)

  -- Draw the title text
  love.graphics.setColor(15, 100, 215)
  love.graphics.setFont(self.title_font)
  love.graphics.printf('Tacktx', 0, height*(1/4), width, 'center')

  -- Reuse the same code and draw the credits button in the same place
  self.start_button_x = (width - self.button_width)/2
  self.start_button_y = (height - self.button_height)/2
  self.credits_button_x = self.start_button_x
  self.credits_button_y = self.start_button_y + self.button_height*1.2

  love.graphics.setColor(180, 180, 180)
  love.graphics.setFont(self.menu_font)
  love.graphics.rectangle('fill', self.start_button_x, self.start_button_y,
                          self.button_width, self.button_height)
  love.graphics.rectangle('fill', self.credits_button_x, self.credits_button_y,
                          self.button_width, self.button_height)

  if self.start_pressed then
    love.graphics.setColor(15, 155, 60)
  else
    love.graphics.setColor(15, 15, 80)
  end
  love.graphics.printf('Play!', 0, self.start_button_y, width, 'center')

  if self.credits_pressed then
    love.graphics.setColor(15, 155, 60)
  else
    love.graphics.setColor(15, 15, 80)
  end
  love.graphics.printf("Credits", 0, self.credits_button_y, width, 'center')
end

function title_scene:draw_credits()
  width, height = love.graphics.getDimensions()
  love.graphics.setBackgroundColor(225, 255, 125)

  -- Draw the contributors list
  local list_start_y = height*(1/4)
  love.graphics.setColor(15, 100, 215)
  love.graphics.setFont(self.title_font)
  love.graphics.printf('Rich Guilmain', 0, list_start_y, width, 'center')
  love.graphics.printf('Tom DeRensis', 0, list_start_y+40, width, 'center')
  love.graphics.printf('Tim Bertram', 0, list_start_y+80, width, 'center')

  -- Draw the menu
  self.start_button_x = (width - self.button_width)/2
  self.start_button_y = (height - self.button_height)/2
  self.credits_button_x = self.start_button_x
  self.credits_button_y = self.start_button_y + self.button_height*1.2

  love.graphics.setColor(180, 180, 180)
  love.graphics.setFont(self.menu_font)
  love.graphics.rectangle('fill', self.credits_button_x, self.credits_button_y,
                          self.button_width, self.button_height)

  if self.credits_pressed then
    love.graphics.setColor(15, 155, 60)
  else
    love.graphics.setColor(15, 15, 80)
  end
  love.graphics.printf('Return', 0, self.credits_button_y, width, 'center')
end

function title_scene:process_mouse_release(x, y, button)
  local button_pressed = self:get_button(x, y)

  if button_pressed == 'start' and self.menu_state == 'title' then
    self.manager:set_scene('map')
  elseif button_pressed == 'credits' and self.menu_state == 'title' then
    self.menu_state = 'credits'
  elseif button_pressed == 'credits' and self.menu_state == 'credits' then
    self.menu_state = 'title'
  end
  self.start_pressed = false
  self.credits_pressed = false
end

function title_scene:process_mouse_press(x, y, button)
  local button_pressed = self:get_button(x, y)

  if button_pressed == 'start' then
    self.start_pressed = true
  elseif button_pressed == 'credits' then
    self.credits_pressed = true
  end
end

function title_scene:is_inside_button(x, y, button_x, button_y)
  if (x > button_x) and
    (x < button_x + self.button_width) and
    (y > button_y) and
    (y < button_y + self.button_height) then
    return true
  else
    return false
  end
end

-- Return the name of the button pressed
function title_scene:get_button(x, y)
  if self:is_inside_button(x, y, self.start_button_x, self.start_button_y) then
    return 'start'
  elseif self:is_inside_button(x, y, self.credits_button_x,
                               self.credits_button_y) then
    return 'credits'
  end
  return nil
end

return title_scene
