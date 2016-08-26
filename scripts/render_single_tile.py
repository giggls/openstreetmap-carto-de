#!/usr/bin/python
#
# rendere ein einzelnes Tile an einer Koordinate
# benutze es um einen Punkt in verschiedenen Zoomstufen zu rendern.
# render a single tile using mapnik
import math
import sys
import mapnik

def deg2num(lat_deg, lon_deg, zoom):
  lat_rad = math.radians(lat_deg)
  n = 2.0 ** zoom
  xtile = int((lon_deg + 180.0) / 360.0 * n)
  ytile = int((1.0 - math.log(math.tan(lat_rad) + (1 / math.cos(lat_rad))) / math.pi) / 2.0 * n)
  return (xtile, ytile)


def TileToMeters(tx, ty, zoom):
  initialResolution = 20037508.342789244 * 2.0 / 256.0
  originShift = 20037508.342789244
  tileSize = 256.0
  zoom2 = (2.0**zoom)
  res = initialResolution / zoom2
  mx = (res*tileSize*(tx+1))-originShift
  my = (res*tileSize*(zoom2-ty))-originShift
  return mx, my

def TileToBBox(x,y,z):
  x1,y1=TileToMeters(x-1,y+1,z)
  x2,y2=TileToMeters(x,y,z) 
  return x1,y1,x2,y2

if __name__ == "__main__":
  if len(sys.argv) != 5:
    sys.stderr.write("usage: render_single_tile.py <stylefile> z lon lat\n")
    sys.exit(1)
  mapfile = sys.argv[1]
  z=int(sys.argv[2])
  lonx=float(sys.argv[3])
  laty=float(sys.argv[4])
  til = deg2num(lonx, laty, z)
  x = til[0]
  y = til[1]
  m = mapnik.Map(256, 256)
  mapnik.load_map(m, mapfile)
  bba=TileToBBox(x,y,z)
  bbox=mapnik.Box2d(bba[0],bba[1],bba[2],bba[3])
  m.zoom_to_box(bbox)
  im = mapnik.Image(256, 256)
  mapnik.render(m, im)
  sys.stdout.write(im.tostring('png'));
  

