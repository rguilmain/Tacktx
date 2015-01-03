-- A tiled layer on the game map

local class = require 'middleclass'
local geom = require 'util.geometry'
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
  local row = math.floor(y/(self.tile_height * (3/4))) + 1
  local col = math.floor(x/self.tile_width - ((row-1)%2)/2) + 1
  local in_center = (y%(self.tile_height*(3/4)) > self.tile_height*(1/4))

  if not in_center then
    local q = math.floor(x/(self.tile_width/2)) + 1  -- hex quadrant
    local x1 = math.floor((q-1) * self.tile_width/2)
    local x2 = x1 + (self.tile_width/2)
    if (row%2 == 1 and q%2 == 1) or (row%2 == 0 and q%2 == 0) then
      -- we are in a section with positive slope
      local y1 = (1/2) * self.tile_height * (row*(3/2) - 1)
      local y2 = y1 - self.tile_height * (1/4)
      local xp = geom:crossProduct({x1, y1}, {x2, y2}, {x, y})
      -- we are actually on the row above
      if xp > 0 then
        if row%2 == 1 then col = col - 1 end
        row = row - 1
      end
    else
      -- we are in a section with negative slope
      local y1 = (row-1) * self.tile_height * (3/4)
      local y2 = y1 + self.tile_height * (1/4)
      local xp = geom:crossProduct({x1, y1}, {x2, y2}, {x, y})
      -- we are actually on the row above
      if xp > 0 then
        if row%2 == 0 then col = col + 1 end
        row = row - 1
      end
    end
  end
  return row, col
end

function HexTileLayer:getTileCenterFromIndex(row, col)
  local y = (1/4) * self.tile_height * (row * 3 - 1)
  local x = self.tile_width * (col - (row%2)/2)
  return x, y
end

return HexTileLayer
