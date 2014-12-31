-- Add our third party libs to the module load path
package.path = package.path ..
               ';../third_party/middleclass/?.lua;' ..
               ';./third_party/middleclass/?.lua'

function love.load()
  love.window.setTitle("Tacktx")
  love.window.setMode(1000, 750, {resizable=true})

  map = require 'layers.middle_earth'
end

function love.draw()
  map:draw()
end
