

union() {
color("black")
translate([0,60-9*2.54,1.57])
union() {
cube([2.54,8*2.54,1.57]);
translate([9*2.54,0,0])
cube([2.54,8*2.54,1.57]);
}
color("green")
linear_extrude(1.57)
square([25.4,60]);
color("yellow")
translate([0,0,-10])
cube([25.4,40,10]);
}

translate([-5,0,10])
union() {
color("black")
translate([0,60-9*2.54,0.79])
union() {
cube([2.54,8*2.54,7.5]);
translate([9*2.54,0,0])
cube([2.54,8*2.54,7.5]);
}
color("green")
cube([40,60,0.79]);
}

translate([25.4,0,20])
rotate([0,180,0])
union() {
color("black")
translate([0,60-9*2.54,1.57])
union() {
cube([2.54,8*2.54,1.57]);
translate([9*2.54,0,0])
cube([2.54,8*2.54,1.57]);
}
color("green")
cube([25.4,60,1.57]);
color("yellow")
translate([0,0,-10])
cube([25.4,40,10]);
}