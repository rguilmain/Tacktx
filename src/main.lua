-- Add our third party libs to the module load path
package.path = package.path ..
               ';../third_party/middleclass/?.lua;' ..
               ';./third_party/middleclass/?.lua'

function love.load()
  love.window.setTitle("Tacktx")
  love.window.setMode(1000, 750, {resizable=true})

  map = require 'layers.middle_earth'

  x_left = 0
  y_left = 0
  left_button_clicked = false

  x_right = 0
  y_right = 0
  right_button_clicked = false
end

function love.draw()
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
end

function love.mousereleased(x, y, button)
  row, col = map:getTileIndexFromPoint(x, y)
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
