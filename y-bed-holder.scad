inch = 25.4;

rod_dia = 8;
screw_dia = 1/8*inch;

rod_margin = 1/8*inch;
rod_depth = 3/8*inch;

bed_height = 1*inch;

///////////////

piece_width = rod_dia+2*rod_margin; //x
piece_depth = bed_height+rod_dia/2+rod_margin; //y
piece_height = rod_depth+rod_margin; //z

difference()
{
	cube(size=[piece_width,piece_depth,piece_height]);
	translate(v=[piece_width/2,rod_dia/2+rod_margin,rod_margin])
		cylinder(r=rod_dia/2, h=piece_height, $fn=30);
	difference()
	{
		translate(v=[-0.1,-0.1,-0.1])
			cube(size=[piece_width+0.2,
					rod_margin+rod_dia/2+0.1,
					piece_height+0.2]);
		translate(v=[piece_width/2,piece_width/2,-0.2])
			cylinder(r=piece_width/2, h=2*piece_height, $fn=30);
	}
	translate(v=[piece_width/2,rod_margin*2+rod_dia,piece_height/2])
		rotate(a=[-90,0,0])
			cylinder(r=screw_dia/2, h=piece_depth, $fn=16);
}
