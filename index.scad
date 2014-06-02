//------------------------------------------------------------
//	Catapult v2
//
//	(Floating Widget Catapult
//	when projectile_diameter = 30;)
//
//	http://thingiverse.com/Benjamin
//   http://www.thingiverse.com/thing:11910
//------------------------------------------------------------



projectile_diameter = 10;

catapult_length = 50;
catapult_thickness = 1.5;
arm_angle = 45;
play = 0.25;

buildBase = true;
buildArm = true;

//--------------------------------------------
margin = 2;
cw = 2 * projectile_diameter/3; // catapult width
ct = catapult_thickness;
rs = projectile_diameter/3;     // roundness radius
br = rs/3;                      // box roundness
fnrs = 32;
hr = (projectile_diameter-1)/2; // inner hole radius
er = 1.4 * hr;                  // outer hole radius
hw = cw/2;
xs = rs + cw/2;
ys = sqrt((er+rs)*(er+rs)-(hw+rs)*(hw+rs));
lb = catapult_length - 2 * ys - br;

//-------------------- BASE -------------------
base_w = max (15, cw * 1.4);
base_h = catapult_length*0.6;
base_t = ct*1.5;
baseOffW = (buildArm ? base_w/2 + margin : 0);
if (buildBase) {
	translate ([baseOffW, 0, base_t/2])
	difference() {
		union () {
			roundBox(base_w, base_h, base_t, 2);
			// demi-cylindre
			translate ([0, base_h*0.3 , base_t/2])
			rotate (90, [0, -1, 0])
			difference() {
				cylinder(r = base_t*2, h = base_w, center = true);
				translate([-base_t*2, 0, 0])
				cube([base_t*4, base_t*4, base_w*1.5], center=true);
			}

		}
		translate([0, -base_h*0.15, 0])
		roundBox(cw, base_h*0.3, base_t*2, 2);

		translate ([0, base_h*0.3, 0])
		rotate(-arm_angle, [1, 0, 0])
		cube([cw+play,catapult_length, ct+play], center=true );
	}
}


//-------------------- ARM --------------------
offW = (buildBase ? -er - margin: 0);
if (buildArm) {
translate([offW, catapult_length/2 -ys -br, ct/2])

difference() {
	union () {
		cylinder (r=er, h = ct, center=true, $fn=fnrs);
		roundedLink(xs, ys, rs, ct);
		roundedLink(xs, -ys, rs, ct);
		roundedLink(-xs, -ys, rs, ct);
		roundedLink(-xs, ys, rs, ct);

		translate ([xs-rs-br, ys, 0])
		cylinder (r=br, h=ct, center=true, $fn=fnrs);
		translate ([-xs+rs+br, ys, 0])
		cylinder (r=br, h=ct, center=true, $fn=fnrs);
		translate([0, ys, 0])
		cube([2*(xs-rs-br), 2*br, ct], center=true);

		translate([0, -(ys+lb/2-br/2), 0])
		cube([cw, lb - br, ct], center=true);

		translate([cw/2-br, -(ys+lb-br), 0])
		cylinder (r=br, h=ct, center=true, $fn=fnrs);

		translate([-cw/2+br, -(ys+lb-br), 0])
		cylinder (r=br, h=ct, center=true, $fn=fnrs);

		translate([0, -(ys+lb-br), 0])
		cube([2*(xs-rs-br), 2*br, ct], center=true);
		
	}
	cylinder (r=hr, h = ct*1.2, center=true, $fn=fnrs);
}
}
//---------------------------------------------



//---------------------------------------------
module roundedLink(xr, yr, rc, rt) {
	difference () {
		linear_extrude(height=rt, center=true)
		polygon(points=[[0,0],[xr,yr],[0,yr]], paths=[[0,1,2]]);
		translate ([xr, yr, 0])
		cylinder (r=rc, h=rt*1.2, center=true, $fn=fnrs);
	}
}
//---------------------------------------------
module roundBox(bw, bh, bt, rb) {
	union () {
		cube([(bw-2*rb)*1.05, (bh-2*rb)*1.05, bt], center=true);
		translate ([(bw-rb)/2, 0, 0])
		cube([rb, bh-2*rb, bt], center=true);
		translate ([-(bw-rb)/2, 0, 0])
		cube([rb, bh-2*rb, bt], center=true);
		translate ([0, -(bh-rb)/2, 0])
		cube([bw-2*rb, rb, bt], center=true);
		translate ([0, (bh-rb)/2, 0])
		cube([bw-2*rb, rb, bt], center=true);
		translate ([(-bw+2*rb)/2, (bh-2*rb)/2, 0])
		cylinder (r=rb, h = bt, center=true, $fn=fnrs);
		translate ([(bw-2*rb)/2, (bh-2*rb)/2, 0])
		cylinder (r=rb, h = bt, center=true, $fn=fnrs);
		translate ([(-bw+2*rb)/2, (-bh+2*rb)/2, 0])
		cylinder (r=rb, h = bt, center=true, $fn=fnrs);
		translate ([(bw-2*rb)/2, (-bh+2*rb)/2, 0])
		cylinder (r=rb, h = bt, center=true, $fn=fnrs);
	}
}
//---------------------------------------------