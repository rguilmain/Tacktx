function love.load()
    love.window.setTitle("Tacktx")

    -- Load our hex images.
    local tileset = "tilesets/flat_left_right/"
    sheep_hex = love.graphics.newImage(tileset .. "sheep.gif")

    -- h is the distance (in pixels) from the bottom of the tile image to the
    -- bottom of the leftmost or rightmost edge of the hex.
    tile_h = 16

    map_num_cols = 14
    map_num_rows = 12
end

function love.draw()
    for col = 0, map_num_cols - 1 do
        for row = 0, map_num_rows - 1 do
            -- If we're in an odd row, offset the x value by half a tile width.
            local x = (col + (row % 2) * 0.5) * sheep_hex:getWidth()
            local y = row * (sheep_hex:getHeight() - tile_h)
            love.graphics.draw(sheep_hex, x, y)
        end
    end
end
