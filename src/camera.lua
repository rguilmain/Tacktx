
local class = require 'middleclass'

local Camera = class('Camera')

function Camera:initialize()
  self._x = 0
  self._y = 0
  self._scale = 1
  self.rotation = 0
end

function Camera:set()
  love.graphics.push()
  --let's not worry about rotation yet
  --love.graphics.rotate(-self.rotation)
  love.graphics.scale(self._scale)
  love.graphics.translate(-self._x, -self._y)
end

function Camera:unset()
  love.graphics.pop()
end

function Camera:move(dx, dy)
  self._x = self._x + (dx or 0)
  self._y = self._y + (dy or 0)
end

function Camera:rotate(dr)
  self.rotation = self.rotation + dr
end

function Camera:scale(s)
  s = s or 1
  self._scale = self._scale * s
end

function Camera:setX(value)
  if self._bounds then
    self._x = math.clamp(value, self._bounds.x1, self._bounds.x2)
  else
    self._x = value
  end
end

function Camera:setY(value)
  if self._bounds then
    self._y = math.clamp(value, self._bounds.y1, self._bounds.y2)
  else
    self._y = value
  end
end

function Camera:setPosition(x, y)
  if x then self:setX(x) end
  if y then self:setY(y) end
end

function Camera:setScale(s)
  self._scale = s or self._scale
end

function Camera:getScale()
  return self._scale
end

function Camera:getBounds()
  return unpack(self._bounds)
end

function Camera:setBounds(x1, y1, x2, y2)
  self._bounds = { x1 = x1, y1 = y1, x2 = x2, y2 = y2 }
end

function Camera:cursorToWorld(x, y)
  return (x / self._scale) + self._x, (y / self._scale) + self._y
end

return Camera:new()
