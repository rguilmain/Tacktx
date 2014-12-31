-- A map with layers... like an onion

local class = require 'middleclass'

local Map = class('Map')

function Map:initialize(layers)
  self.layers = layers   -- a list of layers
end

function Map:getLayers()
  return self.layers
end

function Map:insertLayer(layer, index)
  table.insert(self.layers, index, layer)
end

return Map
