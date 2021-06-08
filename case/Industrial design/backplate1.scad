color("black")
rotate([90,0,0])
linear_extrude(1.57) 
difference() {
  offset(r=3) offset(delta=-3) polygon(
  [[0,0],[0,35],[44,35],
  [44,15],[100,15],[100,0],[0,0]]);
}