function love.load()
  love.window.setTitle("Tacktx")
  love.window.setMode(1000, 500, {resizable=true})

  Scene_Manager = require 'scenes.scene_manager'
  scene_manager = Scene_Manager:new({['title'] = 'title_scene', ['map'] = 'map_scene'})
  scene_manager:set_scene('title')

  love.keyboard.setKeyRepeat(true)
end

function love.draw()
  scene_manager:draw_scene()
end

function love.update(dt)
  scene_manager:update_scene(dt)
end

function love.mousereleased(x, y, button)
  scene_manager:process_mouse_release(x, y, button)
end

function love.mousepressed(x, y, button)
  scene_manager:process_mouse_press(x, y, button)
end

function love.keypressed(key, isrepeat)
  scene_manager:process_key_press(key, isrepeat)
end
