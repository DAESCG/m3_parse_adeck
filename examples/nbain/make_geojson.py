#!/usr/bin/env python

import json

filename = '/home/nbain/public_html/daescg/m3_parse_adeck/aal112015.dat'
all_points = []
ind_point_features = []
with open(filename) as f:
  for line in f:
    fields = line.split(",")
    model = fields[4].strip()
    init = fields[2].strip()
    if model == 'GFSO' and init == '2015100200':
      lat = fields[6].strip()
      lon = fields[7].strip()
      lat = int(lat[:-1]) / 10.0 * (-1 if lat[-1] == 'S' else 1)
      lon = int(lon[:-1]) / 10.0 * (-1 if lon[-1] == 'W' else 1)
      all_points.append([lon, lat])
      ind_point_features.append({
        "type": "Feature",
        "geometry": {
          "type": "Point",
          "coordinates": [lon, lat],
          "properties": {
            "max_sustained_wind": int(fields[8].strip()),
            "pressure": int(fields[9].strip())
          }
        }
      })

all_points_feature = {
  'type': 'Feature',
  'geometry': {'type': 'LineString', 'coordinates': all_points },
  'properties': {}
}

features = [all_points_feature] + ind_point_features

json_root = {
  'type': 'FeatureCollection',
  'features': features
}

print json.dumps(json_root)
