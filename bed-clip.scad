inch = 25.4;

bed_thickness = 1/8*inch;
bed_elevation = 1/4*inch;
belt_thickness = 2;
clip_thickness = 2;
clip_width = 1/2*inch;
base_width = 1*inch;
base_height = 1/2*inch;


base_total = bed_thickness+bed_elevation+clip_thickness;
clip_total_width = clip_thickness*3+belt_thickness*2;
clip_start = base_width/2-clip_total_width/2;
union()
{
	difference()
	{
		cube(size=[base_total,base_width,clip_width]);
		translate(v=[clip_thickness,-0.1,clip_thickness])
			cube(size=[bed_thickness,base_width+0.2,clip_width]);
	}
	difference()
	{
		translate(v=[base_total,clip_start,0])
			cube(size=[clip_width,clip_total_width,clip_width]);
		translate(v=[base_total,clip_start+clip_thickness,-0.1])
			cube(size=[clip_width+0.1,clip_thickness,clip_width+0.2]);
		translate(v=[base_total,clip_start+3*clip_thickness,-0.1])
			cube(size=[clip_width-clip_thickness,clip_thickness,clip_width+0.2]);
		translate(v=[base_total,clip_start+clip_thickness*4-0.1,-0.1])
			cube(size=[clip_thickness,clip_thickness+0.2,clip_width+0.2]);
	}
}
