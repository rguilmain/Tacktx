-- A tiled layer on the game map

local class = require 'middleclass'

local HexTileLayer = class('HexTileLayer')

function HexTileLayer:initialize(tiles, tile_images)
  self.tiles = tiles -- a matrix of tile image indexes
  self.tile_images = tile_images -- the images to use, assumes same size images

  -- Look at the first tile to see what size our tiles are.
  local _, im = next(tile_images)
  self.tile_height = im:getHeight()
  self.tile_width = im:getWidth()
end

function HexTileLayer:draw()
  local offset = self.tile_height/4 -- assumes flat sides hexagon
  for irow,row in ipairs(self.tiles) do
    for icol,index in ipairs(row) do
      if index > 0 then
        -- If we're in an odd row, offset the x value by half a tile width.
        local x = ((icol - 1) + ((irow - 1) % 2) * 0.5) * self.tile_width
        local y = (irow - 1) * (self.tile_height - offset)
        love.graphics.draw(self.tile_images[index], x, y)
      end
    end
  end
end

function HexTileLayer:getTileIndexFromPoint(x, y)
   -- first assume we are in the center rectangle region of the hex tile
   -- TODO: remove magic numbers
  local row = math.floor(y/48) + 1
  if row%2 == 1 then
    col = math.floor(x/55) + 1
  else
    col = math.floor((x-(55/2))/55) + 1
  end

  local in_center = (y%48 >= 17)

  if not in_center then
    local q = math.floor(x/(55/2)) + 1
    if (row%2 == 1 and q%2 == 1) or (row%2 == 0 and q%2 == 0) then
      -- use cross product
      local x1 = math.floor((q-1)*55/2)
      local y1 = row*48 - 32
      local x2 = x1 + (55/2)
      local y2 = y1 - 16
      local v1 = {x2-x1, y2-y1}
      local v2 = {x2-x, y2-y}
      local xp = v1[1]*v2[2] - v1[2]*v2[1]
      -- we are actually on the row above
      if xp > 0 then
        if row%2 == 1 then col = col - 1 end
        row = row - 1
      end
    else
      -- use cross product
      local x1 = math.floor((q-1)*55/2)
      local y1 = (row-1)*48
      local x2 = x1 + (55/2)
      local y2 = y1 + 16
      local v1 = {x2-x1, y2-y1}
      local v2 = {x2-x, y2-y}
      local xp = v1[1]*v2[2] - v1[2]*v2[1]
      -- we are actually on the row above
      if xp > 0 then
        if row%2 == 0 then col = col + 1 end
        row = row - 1
      end
    end
  end
  return row, col
end

return HexTileLayer
