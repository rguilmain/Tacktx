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
        local x = (icol - (irow % 2) * 0.5) * self.tile_width
        local y = irow * (self.tile_height - offset)
        love.graphics.draw(self.tile_images[index], x, y)
      end
    end
  end
end

return HexTileLayer
