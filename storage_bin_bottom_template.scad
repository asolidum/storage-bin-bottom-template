$fn = 100;

line_height = 3;
line_width = 4;
node_diameter = 22;
node_line_width = 2;
box_length = 18;
box_width = 33;
num_rows = 3;
num_cols = 3;

padding = 0.5;

function is_odd(num) = (num % 2) == 1;
function crosshair_length() = node_diameter+box_length;
function crosshair_width() = node_diameter+box_width;

module node(height, width, diameter) {
    difference() {
        cylinder(h = height, d = diameter);
        translate([0, 0, -1]) {
            cylinder(h = height+2, d = diameter-(width*2));
        }
    }
}

module line(height, width, length) {
    cube([width, length, height], true);
}

module crosshair(line_height, line_width, node_diameter, node_line_width, box_length, box_width) {
    
    // X = length
    // Y = width
    node(line_height, node_line_width, node_diameter);
    
    // Right line
    x_offset = node_diameter/2+box_length/4;
    translate([x_offset, 0, line_height/2]) {
        line(line_height, box_length/2+padding, line_width);
    }
    // Left line
    translate([-x_offset, 0, (line_height/2)]) {
        line(line_height, box_length/2+padding, line_width);
    }
    
    // Top line
    y_offset = node_diameter/2+box_width/4;
    translate([0, y_offset, line_height/2]) {
        line(line_height, line_width, box_width/2+padding);
    }
    // Bottom Line
    translate([0, -y_offset, line_height/2]) {
        line(line_height, line_width, box_width/2+padding);
    }
}

module create_row(num_cols) {
    for (col = [ 0 : num_cols-1]) {
        offset = crosshair_length()*col;
        translate([offset, 0, 0]) {
            crosshair(line_height, line_width, node_diameter, node_line_width, box_length, box_width);
        }
    }
}

    for (row = [0 : num_rows-1]) {
        offset = crosshair_width()*row;
        translate([0, offset, 0]) {
            create_row(num_cols);
        }
    }
