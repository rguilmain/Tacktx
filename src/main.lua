-- Add our third party libs to the module load path
package.path = package.path ..
               ';../third_party/middleclass/?.lua;' ..
               ';./third_party/middleclass/?.lua'

function love.load()
  love.window.setTitle("Tacktx")
  love.window.setMode(1000, 750, {resizable=true})

  map = require 'layers.middle_earth'

  bx = 0
  by = 0
end

function love.draw()
  map:draw()
  love.graphics.setColor(255,255,255)
  love.graphics.circle("fill", bx, by, 20, 20)
end

function love.mousereleased(x, y, button)
  if button == 'l' then
    row, col = map:getTileIndexFromPoint(x, y)
    print("At: " .. row .. ", " .. col)

    bx, by = map:getTileCenterFromIndex(row, col)
  end
end
