// Parameters
N = 6;              // Number of drives (default 5)
drive_thickness = 25.4;  // Drive thickness in mm
drive_width = 101.6;     // Drive width in mm
tolerance = 0.6;    // Tolerance in mm for snug fit
wall_thickness = 3; // Wall thickness in mm
divider_thickness = 3; // Divider thickness in mm
floor_thickness = 5; // Floor thickness in mm
height = 100;       // Total box height in mm

// Computed values
slot_width = drive_thickness + tolerance;       // 26 mm
internal_depth = drive_width + tolerance;       // 102.2 mm
L = 2 * wall_thickness + N * slot_width + (N - 1) * divider_thickness; // Total length
D = 2 * wall_thickness + internal_depth;        // Total depth (108.2 mm)

// Model
difference() {
    // External shape with rounded vertical edges
    hull() {
        translate([wall_thickness, wall_thickness, 0])
            cylinder(r=wall_thickness, h=height, $fn=32);
        translate([L - wall_thickness, wall_thickness, 0])
            cylinder(r=wall_thickness, h=height, $fn=32);
        translate([wall_thickness, D - wall_thickness, 0])
            cylinder(r=wall_thickness, h=height, $fn=32);
        translate([L - wall_thickness, D - wall_thickness, 0])
            cylinder(r=wall_thickness, h=height, $fn=32);
    }
    // Subtract slots for drives
    for (i = [0 : N - 1]) {
        translate([wall_thickness + i * (slot_width + divider_thickness), 
                   wall_thickness, 
                   floor_thickness])
            cube([slot_width, internal_depth, height - floor_thickness]);
    }
}