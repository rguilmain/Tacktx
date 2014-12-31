-- Add our third party libs to the module load path
package.path = package.path ..
               ';../third_party/middleclass/?.lua;' ..
               ';./third_party/middleclass/?.lua'

function love.load()
  love.window.setTitle("Tacktx")
  love.window.setMode(1000, 750, {resizable=true})

  test_layer = require 'test_layer'
end

function love.draw()
  test_layer:draw()
end
