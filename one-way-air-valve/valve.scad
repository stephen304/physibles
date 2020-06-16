chamber_od = 20;
tube_od = 5;
wall_thickness = 3;
dovetail_pin_thickness = 1;
dovetail_slot_slop = 0.1;
dovetail_pin_length = 2;

end_length = 10;
transition_length = 5;
chamber_length = 10;
valve_grid_thickness = 1;
wafer_travel = 2.5;

$fn = 200;

difference() {
    cylinder(d=chamber_od, h=chamber_length/2);
    translate([0, 0, valve_grid_thickness]) cylinder(d=chamber_od-(wall_thickness*2), h=chamber_length/2);
    translate([0, 0, -0.5]) {
        cylinder(d=2, h=valve_grid_thickness+1);
        translate([3, 0, 0]) cylinder(d=1.5, h=valve_grid_thickness+1);
        translate([-3, 0, 0])cylinder(d=1.5, h=valve_grid_thickness+1);
        translate([0, 3, 0]) cylinder(d=1.5, h=valve_grid_thickness+1);
        translate([0, -3, 0])cylinder(d=1.5, h=valve_grid_thickness+1);
    }
    translate([0, 0, -1]) difference() {
        cylinder(d=chamber_od-wall_thickness+dovetail_pin_thickness, h=dovetail_pin_length+1);
        cylinder(d=chamber_od-wall_thickness-dovetail_pin_thickness, h=dovetail_pin_length+1);
    }
}
translate([0, 0, chamber_length/2]) difference() {
    cylinder(d1=chamber_od, d2=tube_od, h=10);
    translate([0, 0, -0.05]) cylinder(d1=chamber_od-wall_thickness, d2=tube_od-wall_thickness, h=10.1);
}

translate([30, 0, 0]) union() {
    difference() {
        cylinder(d=chamber_od, h=chamber_length/2);
        translate([0, 0, valve_grid_thickness]) cylinder(d=chamber_od-(wall_thickness*2), h=chamber_length/2);
        translate([0, 0, -0.5]) {
            cylinder(d=2, h=valve_grid_thickness+1);
            translate([4, 0, 0]) cylinder(d=2, h=valve_grid_thickness+1);
            translate([-4, 0, 0])cylinder(d=2, h=valve_grid_thickness+1);
            translate([0, 4, 0]) cylinder(d=2, h=valve_grid_thickness+1);
            translate([0, -4, 0])cylinder(d=2, h=valve_grid_thickness+1);
        }
    }
    translate([0, 0, 0]) {
        translate([2, 2, 0]) cylinder(d=2, h=chamber_length/2-wafer_travel);
        translate([-2, -2, 0])cylinder(d=2, h=chamber_length/2-wafer_travel);
        translate([-2, 2, 0]) cylinder(d=2, h=chamber_length/2-wafer_travel);
        translate([2, -2, 0])cylinder(d=2, h=chamber_length/2-wafer_travel);
    }
    translate([0, 0, chamber_length/2]) difference() {
        cylinder(d=chamber_od-wall_thickness+dovetail_pin_thickness-dovetail_slot_slop, h=dovetail_pin_length);
        translate([0, 0, -0.5]) cylinder(d=chamber_od-wall_thickness-dovetail_pin_thickness-dovetail_slot_slop, h=dovetail_pin_length+1);
    }
}

translate([0, 30, 0]) cylinder(d=chamber_od-2*wall_thickness, h=0.2); //14
translate([0, -30, 0]) cylinder(d=11, h=0.2); // 4+7
