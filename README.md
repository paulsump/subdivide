# subdivide

Ultimately planning to create a football from a truncated icosahedron. I can load and render one
from an obj file already, but I want full control and understanding of where the vertices are, for
various animation ideas and in order to do the final part of pushing out each face, like how a
football is stitched together, so I'm going to create it from scratch...

| icosahedron_in_octahedron | icosahedron_subdivided_frequency_3 |
| ------------- | ------------- |
| <img src="https://github.com/paulsump/subdivide/blob/e4fc24163952fd9b314cb9e8e5e604c7b5b1a716/images/icosahedron_in_octahedron.png" width="248">  | <img src="https://github.com/paulsump/subdivide/blob/e4fc24163952fd9b314cb9e8e5e604c7b5b1a716/images/icosahedron_subdivided_frequency_3.png" width="248"> | 

| geodesic_polyhedron | truncated_icosahedron |
| ------------- | ------------- |
| <img src="https://github.com/paulsump/subdivide/blob/e4fc24163952fd9b314cb9e8e5e604c7b5b1a716/images/truncated_icosahedron.png" width="248">  | <img src="https://github.com/paulsump/subdivide/blob/e4fc24163952fd9b314cb9e8e5e604c7b5b1a716/images/geodesic_polyhedron.png" width="248"> | 

## TODO

- Create coordinates for tetrahedron (top half of octahedron)
- Create coords of top half of icosahedron by subdividing at 'midpoint' along tetrahedron's edges,
  where 'midpoint' is the golden ratio.
- Mirror top to bottom to create icosahedron.
- Subdivide with frequency 3.
- Color the black parts of the football and push everything out to unit radius.
