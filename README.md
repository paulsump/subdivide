# subdivide

Ultimately planning to create a football from a truncated icosahedron. I can load and render one
from an obj file already, but I want full control and understanding of where the vertices are, in
order to do the final part of pushing out each patch of the bucky ball, like how a football is
stitched together, so I'm going to create it from scratch...

### First step: Spherical coordinates

From [Wikipedia](https://en.wikipedia.org/wiki/Regular_icosahedron)
"The locations of the vertices of a regular icosahedron can be described using spherical
coordinates, for instance as latitude and longitude. If two vertices are taken to be at the north
and south poles (latitude ±90°), then the other ten vertices are at latitude ± arctan(0.5) =
±26.57°. These ten vertices are at evenly spaced longitudes (36° apart), alternating between north
and south latitudes.

This scheme takes advantage of the fact that the regular icosahedron is a pentagonal gyroelongated
bipyramid"... .
<img src="https://github.com/paulsump/subdivide/blob/32e35399d3873fb33e89ac7f58869133188cac9d/images/pentagonal_gyroelongated_bipyramid.png" >

### Then...

I'm going to make a patch (like a patch work quilt) for a pentagon and for a hexagon and put them in
the places dictated by the vertices described by the picture above. they'll look abit like this, but
there won't be need for triangles..

| geodesic_polyhedron | truncated_icosahedron |
| ------------- | ------------- |
| <img src="https://github.com/paulsump/subdivide/blob/e4fc24163952fd9b314cb9e8e5e604c7b5b1a716/images/truncated_icosahedron.png" width="248">  | <img src="https://github.com/paulsump/subdivide/blob/e4fc24163952fd9b314cb9e8e5e604c7b5b1a716/images/geodesic_polyhedron.png" width="248"> | 

## TODO

- Create vertices of icosahedron using the spherical coords idea above (but I'll use a radius of
  root5/2, an x of 1 and a height of 0.5 (atan(0.5)).
- Place pentagon patch at each vertex described above
- Place hexagon patch at the mid point of each equilateral triangle of the vertices described above.
- Round of the edges of each patch to make it look like the ball is stitched together.
