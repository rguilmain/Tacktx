function love.load()
  love.window.setTitle("Tacktx")
  love.window.setMode(1000, 750, {resizable=true})

  map = require 'assets.maps.middle_earth'
  camera = require 'camera'

  x_left = 0
  y_left = 0
  left_button_clicked = false

  x_right = 0
  y_right = 0
  right_button_clicked = false

  love.keyboard.setKeyRepeat(true)
end

function love.draw()
  camera:set()
  love.graphics.setColor(255, 255, 255, 255)
  map:draw()
  if left_button_clicked then
    love.graphics.setColor(0, 0, 255, 200)
    love.graphics.circle("fill", x_left, y_left, 20, 20)
  end
  if right_button_clicked then
    love.graphics.setColor(255, 0, 0, 200)
    love.graphics.circle("fill", x_right, y_right, 20, 20)
  end
  camera:unset()
end

function love.mousereleased(x, y, button)
  -- convert our click to world coordinates and calculate tile index
  wx, wy = camera:cursorToWorld(x, y)
  row, col = map:getTileIndexFromPoint(wx, wy)
  print("At: " .. row .. ", " .. col)

  if button == 'l' then
    x_left, y_left = map:getTileCenterFromIndex(row, col)
    left_button_clicked = true
    right_button_clicked = false
  elseif button == 'r' then
    if not left_button_clicked then
      return
    end
    x_right, y_right = map:getTileCenterFromIndex(row, col)
    right_button_clicked = true
  end
end

function love.mousepressed(x, y, button)
  if button == "wu" then
    -- zoom into the world
    camera:scale(1.1)
  elseif button == "wd" then
    -- zoom out of the world
    camera:scale(0.9)
  end
end

function love.keypressed(key, isrepeat)
  -- TODO: Combine with love.keyreleased to implement diagonal scrolling
  translate_amount = 20
  if key == 'up' then
     camera:move(0, -translate_amount)
  elseif key == 'down' then
     camera:move(0, translate_amount)
  elseif key == 'left' then
     camera:move(-translate_amount, 0)
  elseif key == 'right' then
     camera:move(translate_amount, 0)
  end
end
