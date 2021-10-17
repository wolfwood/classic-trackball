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

position=[-49,-3,-0.5];
magnetize(position) import( "../../Mechanicals/STLs/Base.stl");
