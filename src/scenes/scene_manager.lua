-- The pompous director of scenes

local class = require 'third_party.middleclass.middleclass'

local scene_manager = class('scene_manager')

-- Initialize the scene manager with a table of scenes. The scenes should not
-- be scene objects, but rather a scene name which is assumed to be in the
-- 'scenes' folder or on the lua path. This is so that a scene object can be
-- selectivly loaded into memory only when it is needed. The current scene is
-- set to the first entry in the table by default.
function scene_manager:initialize(scenes)
  self.scenes = {}
  -- Add each scene and look for errors as we do it.
  for identifier, scene_path in pairs(scenes) do
    self:add_scene(identifier, scene_path)
  end

  -- A scene hasn't been set yet
  self.current_scene_identifier = nil
  self.current_scene_object = nil
end

-- Add a scene to the manager with the given identifier and scene path.
function scene_manager:add_scene(identifier, scene_path)
  local scene = require('scenes.' .. scene_path)
  if scene ~= nil then
    -- assume we received a scene in the scenes directory
    self.scenes[identifier] = 'scenes.' .. scene_path
  else
    -- maybe the scene path is in the lua path
    scene = require(scene_path)
    if scene ~= nil then
      self.scenes[identifier] = scene_path
    else
      print('Error: Scene ' .. scene_path .. ' not found in the lua path.')
    end
  end
end

-- Set the current scene to be rendered by the scene manager. If the desired
-- scene matches the desired scene, then the scene will be reloaded.
function scene_manager:set_scene(identifier)
  local scene_name = self.scenes[identifier]
  if scene_name ~= nil then
    -- load the scene, we already know it exists in the lua path
    self.current_scene_identifier = identifier
    local scene_object = require(scene_name)
    self.current_scene_object = scene_object:new(self)
  else
    print('Error: Scene ' .. identifier .. ' not found in the scene table.')
  end
end

-- Draw the current scene set by set_scene()
function scene_manager:draw_scene()
  if self.current_scene_object ~= nil then
    self.current_scene_object:draw()
  else
    print('Error: No scene set! Set a scene using set_scene(identifier).')
  end
end

function scene_manager:process_mouse_release(x, y, button)
  -- Just pass it onto the scene for now
  self.current_scene_object:process_mouse_release(x, y, button)
end

function scene_manager:process_mouse_press(x, y, button)
  -- Just pass it onto the scene for now
  self.current_scene_object:process_mouse_press(x, y, button)
end

function scene_manager:process_key_press(key, is_repeat)
  -- Just pass it onto the scene for now
  self.current_scene_object:process_key_press(key, is_repeat)
end

return scene_manager
