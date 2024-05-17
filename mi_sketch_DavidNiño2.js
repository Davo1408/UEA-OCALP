// 1. initImage: Inicializa una imagen como fuente
s0.initImage("https://archive.org/download/15000LineSegments/15000_Line_Segments.jpg")

// Fuente: imagen inicializada en s0
src(s0)
  // 2. blend: Combina la imagen con una fuente de oscilación
  .blend(osc(10, 0.1, 0.8), 0.5)
  // 3. modulate: Modula la imagen combinada con una fuente voronoi
  .modulate(voronoi(5), 15)
  .out()