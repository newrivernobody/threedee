/*
Secret Jardin Lodge 160 Tent Parts
*/

/*
6" Duct Flange (150mm)
*/

module 6_duct_flange() {
    nominal_diameter=159;
    fit_tolerance=.003;
    actual_diameter=nominal_diameter-(nominal_diameter*fit_tolerance);
    outside_rad=actual_diameter/2;
    
    locking_tab_width=4;
    locking_tab_len=67;
    
}

/*
Light Blocker (150mm)
*/

module 150_light_blocker() {
    nominal_diameter=150;
    fit_tolerance=.003;
    actual_diameter=nominal_diameter-(nominal_diameter*fit_tolerance);
    outside_rad=actual_diameter/2;
    
    /*
    4 stack is 36.5mm thick = 9.125 thick each (or so)
    edges have .75mm wide rabbet at ends that is same as @locking_tab_width above (4mm at first measure)
    3x notched keys on each edge are 2mm deep\tall and 13mm long
    15 fins, 45 degree (or so) angle
    fins supported by 10x supports that run perpendicular
    */
}

