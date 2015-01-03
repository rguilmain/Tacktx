local geometry = {}

function geometry:crossProduct(pl1, pl2, p)
  local v1 = {pl2[1]-pl1[1], pl2[2]-pl1[2]}
  local v2 = {pl2[1]-p[1], pl2[2]-p[2]}
  return v1[1]*v2[2] - v1[2]*v2[1]
end

return geometry
