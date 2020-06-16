chamber_od = 40;
tube_od = 15;
wall_thickness = 3;
wall_thickness_tube = 2;
dovetail_pin_thickness = 1;
dovetail_slot_slop = 0.15;
dovetail_pin_length = 1.5;

tube_length = 10;
transition_length = 10;
chamber_length = 10;
valve_grid_thickness = 3;
wafer_travel = 2.5;
grid_hole_diameter = 2;

$fn = 200;

// In flow
difference() {
    cylinder(d=chamber_od, h=valve_grid_thickness);
    // Holes
    translate([0, 0, -0.5]) {
        cylinder(d=2, h=valve_grid_thickness+1);
        for (a = [0:60:360]) {
            rotate([0, 0, a]) translate([3.5, 0, 0]) cylinder(d=grid_hole_diameter, h=valve_grid_thickness+1);
        }
        for (a = [0:30:360]) {
            rotate([0, 0, a]) translate([7, 0, 0]) cylinder(d=grid_hole_diameter, h=valve_grid_thickness+1);
        }
    }
    
    // Dovetail slot
    translate([0, 0, -1]) difference() {
        cylinder(d=chamber_od-(wall_thickness*2)+dovetail_pin_thickness*2+dovetail_slot_slop, h=dovetail_pin_length+1);
        cylinder(d=chamber_od-(wall_thickness*2)-dovetail_slot_slop, h=dovetail_pin_length+1);
    }
    translate([-50, -100, -1]) cube([100, 100, 100]);
}
// Cone
translate([0, 0, valve_grid_thickness]) difference() {
    cylinder(d1=chamber_od, d2=tube_od, h=transition_length);
    translate([0, 0, -0.05]) cylinder(d1=chamber_od-wall_thickness*2, d2=tube_od-wall_thickness_tube*2, h=transition_length + 0.1);
}
// Breathing tube
translate([0, 0, valve_grid_thickness+transition_length]) difference() {
    cylinder(d=tube_od, h=tube_length);
    translate([0, 0, -0.5]) cylinder(d=tube_od-wall_thickness_tube*2, h=tube_length+1);
}

// Out flow
translate([chamber_od + 10, 0, 0]) union() {
    difference() {
        cylinder(d=chamber_od, h=chamber_length);
        translate([0, 0, valve_grid_thickness]) cylinder(d=chamber_od-(wall_thickness*2), h=chamber_length);
        translate([0, 0, -0.5]) {
            // Holes
            cylinder(d=2, h=valve_grid_thickness+1);
            for (a = [0:60:360]) {
                rotate([0, 0, a]) translate([3.5, 0, 0]) cylinder(d=grid_hole_diameter, h=valve_grid_thickness+1);
            }
            for (a = [0:30:360]) {
                rotate([0, 0, a]) translate([7, 0, 0]) cylinder(d=grid_hole_diameter, h=valve_grid_thickness+1);
            }
            for (a = [0:20:360]) {
                rotate([0, 0, a]) translate([10, 10, 0]) cylinder(d=grid_hole_diameter, h=valve_grid_thickness+1);
            }
        }
    }
    // Pins
    translate([0, 0, 0]) {
        for (a = [0:90:360]) {
            rotate([0, 0, a]) translate([4, 4, 0]) cylinder(d=2, h=chamber_length-wafer_travel);
        }
        for (a = [0:45:360]) {
            rotate([0, 0, a+45]) translate([8, 8, 0]) cylinder(d=2, h=chamber_length-wafer_travel);
        }
    }
    // Dovetail thing
    translate([0, 0, chamber_length]) difference() {
        cylinder(d=chamber_od-wall_thickness*2+dovetail_pin_thickness*2, h=dovetail_pin_length);
        translate([0, 0, -0.5]) cylinder(d=chamber_od-wall_thickness*2, h=dovetail_pin_length+1);
    }
}

// Diaphragm
translate([0, chamber_od + 10, 0]) {
    difference() {
        cylinder(d=chamber_od-2*wall_thickness, h=0.2); //14
        for (a =[0:20:360]){
            rotate([0, 0, a]) translate([10, 10, -0.5]) cylinder(d=grid_hole_diameter, h=valve_grid_thickness+1);
        }
    }
}
