inch = 25.4;

base_rounded_radius = 1/4*inch;
riser_rounded_radius = 1/16*inch;

base_thickness = 0.197*inch;
base_hw = 2.756*inch;
base_corner_radius = 0.1*inch;
base_side_cutout_radius = 0.6*inch;

riser_thickness = 0.638*inch;
riser_height = 2*inch;
riser_hole_offset = 1/8*inch;

mounthole_dia= 0.145*inch;
mounthole_hw = 1.220*inch;

rod_dia = 3/8*inch;
rod_holder_thickness = 1/8*inch;

rod_loc = [base_hw/2-rod_dia-1/16,base_hw/2,0];
cutout_width = base_hw-2*rod_dia-4*riser_hole_offset;
side_cutout_offset = [base_hw/2, 2*riser_hole_offset+rod_dia, base_thickness+rod_dia+riser_hole_offset];

difference()
{
	union()
	{
		base();
		riser();
		rodholder();
	}
	rod();
	transverse_rod();
}

module rounded_corner(h, rad)
{
	difference()
	{
		translate(v=[-0.1,-0.1,-0.1]) cube( size = [rad+0.1, rad+0.1, h+0.2] );
		translate(v=[rad, rad, -0.2]) cylinder( h=h+0.4, r=rad, $fn=20);
	}
}

module base()
{
	difference()
	{
		cube( size = [base_hw, base_hw, base_thickness]);
		translate( v=[0,base_hw/2,-0.1] )
			cylinder(h=base_thickness+0.2, r=base_side_cutout_radius, $fn = 40);
		translate( v=[base_hw,base_hw/2,-0.1] )
			cylinder(h=base_thickness+0.2, r=base_side_cutout_radius, $fn = 40);
		
		for(i=[0:1])
		{
			for(j=[0:1])
			{
				translate(v=[base_hw*i,base_hw*j,0])
				rotate(a=[0,0,-90*(3*i+j)+floor((3*i+j)/4)*180])
				rounded_corner(base_thickness, base_rounded_radius);
			}
		}
		for( i = [-1, 1])
		{
			for( j = [-1, 1])
			{
				translate( v=[base_hw/2-mounthole_hw*i/2,base_hw/2-mounthole_hw*j/2,-0.1] )
					cylinder(h=base_thickness+0.2, r=mounthole_dia/2, $fn=20);
			}
		}
	}
}

module rod()
{
	translate(v=rod_loc+[0,0,-0.1])
			cylinder(h=riser_height+0.1,r=rod_dia/2, $fn=20);
}

module transverse_rod()
{
	rotate(a = [-90,0,0], v=[0,0,0])
		translate(v=[base_hw/2,-rod_dia/2-base_thickness,-0.1])
			cylinder(h=2*base_hw, r=rod_dia/2, $fn=20);
}

module rodholder()
{
	union()
	{
		translate(v=rod_loc+[0,0,base_thickness])
			cylinder(h=riser_height, r=rod_dia/2+rod_holder_thickness, $fn=40);
		translate(v=rod_loc+[0, -rod_dia/2-rod_holder_thickness,base_thickness])
			cube(size = [rod_dia/2+rod_holder_thickness, rod_dia+2*rod_holder_thickness, riser_height]);
	}
}

module riser()
{
	difference()
	{
		translate(v=[base_hw/2-riser_thickness/2,0,base_thickness])
			cube(size = [riser_thickness, base_hw, riser_height]);

		//side cutout
		translate(v=side_cutout_offset)
				cube(size = [riser_thickness,cutout_width,riser_height]);

		for(i = [0,1])
		{
			//cutout convex rounded corner
			translate(v=[base_hw/2+riser_thickness/2,(1-2*i)*(riser_hole_offset*2+rod_dia)+base_hw*i,base_thickness+rod_dia+riser_hole_offset])
			rotate(a=[0,0,-180-90*i])
				rounded_corner(riser_height, riser_rounded_radius);
		}

		for(i = [0,1])
		{
			for(j = [0,1])
			{
				//outside rounded corners
				translate(v=[
						base_hw/2-riser_thickness*(1-2*i)/2,
						base_hw*j,
						base_thickness])
				rotate(a=[0,0,-90*(3*i+j)+floor((3*i+j)/4)*180])
					rounded_corner(riser_height, riser_rounded_radius);

				//Transverse rods
				translate(v=[0,
					riser_hole_offset + rod_dia/2 + j*(base_hw-rod_dia-2*riser_hole_offset),
					base_thickness+rod_dia*3/2 + i*(riser_height-2*rod_dia-riser_hole_offset)])
					rotate(a = [0,90,0], v=[0,0,0])
						cylinder(h=base_hw, r=rod_dia/2, $fn=20);
			}
		}
	}
}
