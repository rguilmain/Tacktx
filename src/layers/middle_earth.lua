local HexTileLayer = require 'layer'

layer =
{
   { 2,  2,  1,  1,  1,  1,  4,  4,  4,  4,  4,  4,  4,  4},
   {   2,  4,  1,  1,  1,  1,  4,  4,  3,  3,  1,  1,  4,  4},
   { 2,  4,  1,  1,  1,  1,  3,  4,  1,  3,  3,  1,  5,  1},
   {   2,  2,  1,  3,  1,  1,  4,  4,  3,  3,  1,  1,  4,  2},
   { 2,  1,  3,  1,  1,  1,  4,  3,  1,  3,  1,  1,  4,  2},
   {   2,  2,  3,  1,  1,  1,  3,  1,  1,  1,  1,  5,  1,  1},
   { 2,  2,  2,  2,  1,  1,  4,  4,  4,  1,  4,  4,  4,  4},
   {   2,  2,  2,  2,  1,  4,  1,  1,  4,  1,  4,  1,  1,  1},
   { 2,  2,  2,  2,  4,  1,  1,  4,  4,  5,  5,  4,  4,  4},
   {   2,  2,  2,  2,  2,  2,  2,  2,  5,  5,  5,  5,  5,  5},
}

-- Load our hex images.
local tileset = "tilesets/flat_left_right/"
sheep_hex = love.graphics.newImage(tileset .. "sheep.gif")
water_hex = love.graphics.newImage(tileset .. "water.gif")
wood_hex = love.graphics.newImage(tileset .. "wood.gif")
ore_hex = love.graphics.newImage(tileset .. "ore.gif")
desert_hex = love.graphics.newImage(tileset .. "desert.gif")

tile_images = ({sheep_hex, water_hex, wood_hex, ore_hex, desert_hex})

return HexTileLayer:new(layer, tile_images)
