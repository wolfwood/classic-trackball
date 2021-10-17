// makes a number of clones of a subtree, rotated and spaced evenly around the origin
module rotational_clone(clones=2) {
  for(i=[0:clones-1] ) {
    rotate([0,0,i * (360/clones)]) children();
  }
}


module magnetize(position=[0,0,0]) {
  union() {
    difference() {
      /* idk why you would call this on a set of objects since there is only one position, but just in case
       *   union the children because otherwise the difference will subtract the subsequent children from the first one
       */
      union(){
	children();
      }

      /* a loose fitting hole for the magnet, bringing it is closer to the work surface
       *   (force is proportional to the square of distance), maybe also provides some support when moving laterally
       */
      translate(position) cylinder(9,d=33,$fn=64);
    }
    // change diameter if you need to accomodate a different screw size
    translate(position) cylinder(12,d=3.5,$fn=64);
  }
}

module bar_magnetize_below(position=[0,0,0], rotation=[0,0,0], spacer=0, walls=2, ceiling=2) {
  bar = [14, 60.5, 6.3];
  epsilon=1.1;

  outer = bar+[2*walls,2*walls,ceiling+spacer];
  difference() {
    union(){
      children();

      translate(position+[0,0,outer.z/2]) rotate(rotation) cube(outer, true);
    }
    translate(position) rotate(rotation) {
      translate([0,0,(bar.z/2 + spacer - epsilon)]) cube(bar+[0,0,epsilon*2], true);
      rotational_clone() translate([0,45/2,0]) cylinder($fn=60,h=2*(outer.z+epsilon), d=3.6, center=true);
    }
  }
}


//position=[-49,-3,-0.5];
position=[-46,-4,-1.8];
bar_magnetize_below(position, [0,0,90]) import( "../../Mechanicals/STLs/Base.stl");
