function love.load()
    -- Load our hex images.
    tileset = "tilesets/flat_left_right/"
    sheep_hex = love.graphics.newImage(tileset .. "sheep.gif")

    -- Set our tile dimensions.
    -- TODO(Rich): Get these dimensions from the images themselves
    tile_width = 55
    tile_height = 64
    -- h is the distance (in pixels) from the bottom of the image to the bottom
    -- of the leftmost or rightmost edge of the hex
    tile_h = 16

    map_num_cols = 14
    map_num_rows = 12
end

function love.draw()
    for col = 0, map_num_cols - 1 do
        for row = 0, map_num_rows - 1 do
            -- If we're in an odd row, offset the x value by half a tile width.
            x = (col + (row % 2) * 0.5) * tile_width
            y = row * (tile_height - tile_h)
            love.graphics.draw(sheep_hex, x, y)
        end
    end
end