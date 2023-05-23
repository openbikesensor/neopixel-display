$fn = 128;

small_printbed = true;

pixel_distance = 10;
pixel_wall = 0.8;

// width_pixels = 64;
// height_pixels = 8;
width_pixels = 32;
height_pixels = 8;

cap_size = 2.6;
cap_height = 0.8;

grid_width = width_pixels * pixel_distance + pixel_wall;
grid_height = height_pixels * pixel_distance + pixel_wall;
grid_thickness = 3.0;

padding = 7;

module Diffusers() {
  thickness = 0.2;
  translate([0, 0, grid_thickness - thickness])
    union() {
      for (x = [0:width_pixels - 1], y = [0:height_pixels - 1]) {
        translate([x * pixel_distance + pixel_wall, y * pixel_distance + pixel_wall, 0])
          cube([pixel_distance - pixel_wall, pixel_distance - pixel_wall, thickness]);
      }
    }
}


module DiffuserGrid() {
  difference() {
    cube([grid_width, grid_height, grid_thickness,]);

    for (x = [0:width_pixels - 1], y = [0:height_pixels - 1]) {
      translate([x * pixel_distance + pixel_wall, y * pixel_distance + pixel_wall, - 1])
        cube([pixel_distance - pixel_wall, pixel_distance - pixel_wall, grid_thickness + 2]);
    }

    // Add a little notch in the vertical grid walls for the capacitors.
    for (y = [0:height_pixels - 1]) {
      translate([pixel_wall, (y + 0.5) * pixel_distance + pixel_wall - cap_size / 2, - 1])
        cube([grid_width - 2 * pixel_wall, cap_size, 1 + cap_height]);
    }
  }
}


module RoundedCube(dim, r) {
  hull()
    for (x = [0, 1], y = [0, 1])
    translate([x == 1 ? dim.x - r : r, y == 1 ? dim.y - r : r, 0])
      cylinder(r = r, h = dim.z);
}

module FrontPanel() {
  difference() {
    translate([- padding, - padding, 0])
      RoundedCube([grid_width + 2 * padding, grid_height + 2 * padding, grid_thickness], 5.0);

    translate([0, 0, - 2])
      cube([grid_width, grid_height, 20]);
  }
}


module ScrewConnector(negative = false) {
  intersection() {
    difference() {
      cube([14, 8, 8]);

      // insert
      translate([6, 4, 4])
        rotate([0, 90, 0])
          cylinder(d = 4, h = 6);

      // hole
      translate([0, 4, 4])
        rotate([0, 90, 0])
          cylinder(d = 3.25, h = 6);

      // head
      translate([0, 4, 4])
        rotate([0, 90, 0])
          cylinder(d = 6, h = 3);
    }

    translate([negative ? 6 : - 100 + 6, 0, 0])
      cube([100, 8, 8]);
  }
}

module ScrewHole() {
  // hole
  translate([0, 0, - 1])
    rotate([0, 0, 0])
      cylinder(d = 3.75, h = 6);
}


module FrontPanelWithHoles() {
  color([1, 1, 1])
    Diffusers();
  DiffuserGrid();
  //FrontPanel();

  difference() {
    FrontPanel();
    for (i = [29.35:87.1:290.65]) {
      for (j = [- 4.05, 83.903]) {
        translate([i, j, 0]) ScrewHole();
      }
    }
  };
}

  if (small_printbed) {
    intersection() {
      FrontPanelWithHoles();
      translate([- 30, - 10, 0])cube([16 * pixel_distance + pixel_wall / 2 + 30, 400, 8]);
    }
    translate([16*pixel_distance-padding,8*pixel_distance+2*padding+5])mirror([1,0,0])intersection() {
      FrontPanelWithHoles();
      translate([- 30, - 10, 0])cube([16 * pixel_distance + pixel_wall / 2 + 30, 400, 8]);
    }
  } else {
    FrontPanelWithHoles();
  }


//ScrewConnector(false);

//rotate([0,90,0])
//translate([-10, 10, ])
//ScrewConnector(true);

// part = "black";
//
// translate([0, 0, grid_thickness])
// rotate([180, 0, 0]) {
//     if (part == "white") {
//         Diffusers();
//     } else {
//         DiffuserGridBottom();
//     }
// }



// translate([0, 0, 3])
// DiffuserGrid(2.0);
