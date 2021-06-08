color("black")
translate([96-25.4,60-9*2.54,1.57])
linear_extrude(1.57)
union() {
  square([2.54,8*2.54]);
  translate([9*2.54,0,0])
    square([2.54,8*2.54]);
}

color("green")
linear_extrude(1.57) 
difference() {
  offset(r=3) offset(delta=-3) polygon(
  [[0,0],[0,60],[100,60],
  [100,0],[0,0]]);
  translate([96,30,0]) square([4,30]);
  translate([96-(25.4)-30,30,0]) square([30,30]);
}