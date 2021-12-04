//legacy
body_ht=16;
body_od_rad=12;

//fn values
smooth=128;

body_rad=14;

pivot_ht=16;
pivot_rad=body_rad*1.2;

clip_arm_ht=16;
clip_ht=3;
clip_arm_len=75;
clip_width=12;
clip_rad=clip_width/2;

peg_rad_max=clip_rad;
peg_rad_min=1;
peg_width=20;
peg_ht=16;

hole_rad=8;

//num_edges is how many edges are in the locking pivot point
module clip_insert(num_edges,fit_tolerance) {
    difference() {
        union() {
            //clip plate
            hull() {
                cylinder(h=clip_ht,r=pivot_rad,$fn=smooth);
                translate([clip_arm_len-(pivot_rad+clip_rad),0,0]) cylinder(h=clip_ht,r=clip_width/2,$fn=smooth);
            }
            //pivot
            translate([0,0,clip_ht]) cylinder(h=body_ht,r=body_od_rad*fit_tolerance,$fn=num_edges);
            //peg
            translate([clip_arm_len-(pivot_rad+clip_rad),0,clip_ht]) rotate([0,0,26.4]) hull() {
                cylinder(h=peg_ht,r=peg_rad_max,$fn=smooth);
                translate([-peg_width,0,0]) cylinder(h=peg_ht,r=peg_rad_min,$fn=smooth);
            }   
        }
        union() {
            //center hole
            translate([0,0,-1]) cylinder(h=pivot_ht*2,r=hole_rad,$fn=smooth);
            //peg hole
            translate([clip_arm_len-(pivot_rad+clip_rad),0,-1]) cylinder(h=peg_ht*2,r=peg_rad_max*.6,$fn=smooth);
            //peg swoop
            translate([clip_arm_len-(pivot_rad+clip_rad),16,11]) rotate([0,270,26.4*1.55]) cylinder(h=peg_width*2,r=peg_ht/2,$fn=smooth);         
        }
    }
}

module pivot_with_swoop() {
    difference() {
      cylinder(h=body_ht,r=pivot_rad,$fn=smooth,center=true);
      //rotate_extrude(convexity=100) translate([body_ht*1.4,0,0]) circle(r=body_ht/2.2,$fn=smooth);
      rotate_extrude(convexity=10,$fn=smooth) translate([body_ht*1.4,0,0]) circle(r=body_ht/2.2,$fn=smooth);
    }
}

//num_edges is how many edges are in the locking pivot point
module clip_body(num_edges) {
    difference() {
        union() {
            //clip plate
            hull() {
                cylinder(h=clip_ht,r=pivot_rad,$fn=smooth);
                translate([clip_arm_len-(pivot_rad+clip_rad),0,0]) cylinder(h=clip_ht,r=clip_width/2,$fn=smooth);
            }           
            //peg
            translate([clip_arm_len-(pivot_rad+clip_rad),0,clip_ht]) rotate([0,0,26.4]) hull() {
                cylinder(h=peg_ht,r=peg_rad_max,$fn=smooth);
                translate([-peg_width,0,0]) cylinder(h=peg_ht,r=peg_rad_min,$fn=smooth);
            }
            //pivot
            //translate([0,0,clip_ht]) cylinder(h=body_ht,r=pivot_rad,$fn=smooth);
            translate([0,0,clip_ht+(body_ht/2)]) pivot_with_swoop();
        }
        union() {
            //octo hole
            translate([0,0,-1]) cylinder(h=body_ht*2,r=body_od_rad,$fn=num_edges);            
            //peg hole
            translate([clip_arm_len-(pivot_rad+clip_rad),0,-1]) cylinder(h=peg_ht*2,r=peg_rad_max*.6,$fn=smooth);
        }
            //swoop
            translate([clip_arm_len-(pivot_rad+clip_rad),16,11]) rotate([0,270,26.4*1.55]) cylinder(h=peg_width*2,r=peg_ht/2,$fn=smooth);                 
    }
}

//meshed together
module meshed(rotate_y,rotate_x,rotate_z,ht,num_edges,fit_tolerance){
    color("green") clip_insert(num_edges,fit_tolerance);
    //color("red") translate([0,0,30]) rotate([180,0,90]) clip_body(num_edges);
    color("red") translate([0,0,ht]) rotate([rotate_x,rotate_y,rotate_z]) clip_body(num_edges);
}

//plate octogon
module plate(num_edges,fit_tolerance) {
    color("green") translate([clip_arm_len-pivot_rad*2,0,0]) rotate([0,0,180]) clip_insert(num_edges,fit_tolerance);
    color("red") translate([0,40,0]) rotate([0,0,0]) clip_body(num_edges);
}

plate(8,.99);

//example of meshed output
/*
180, 0, 90 -- rotate_x, rotate_y, rotate_z = rotation of mesh
30 -- ht = height of mesh -- clip_ht should be smallest
8 -- num_edges = number of articulations on clips
.99 -- fit_tolerance = fit of the insert into the body
*/
//meshed(180,0,90,30,8,.99);