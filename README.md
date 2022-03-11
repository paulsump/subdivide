# subdivide

Ultimately planning to create a football from a truncated icosahedron.
I can load and render one from an obj file already,
but I want full control and understanding of where the 
vertices are, for various animation ideas and 
in order to do the final part of pushing out each face, like how a football is stiched
together, so I'm going to create it from scratch...

## TODO
- Create face class. Not sharing vertices with the whole object is simpler and sharing vertices
  might hinder some animations that e.g. rotate the faces.
- Create coordinates for tetrahedron (top half of octahedron)
- Create coords of top half of icosahedron by finding 'midpoint'
- Along tetrahedron's edges, where 'midpoint' is the golden ratio.

