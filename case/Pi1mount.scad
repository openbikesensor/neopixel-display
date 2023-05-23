$fn=100;
size=[85,56];
holes=[[25.5,18],size - [5,12.5]];

linear_extrude(1)difference(){
   offset(2)translate(holes[0]-[5,5])square(holes[1]-holes[0]+[10,10]);
   translate(holes[0]+[10,18])circle(10);
   translate(holes[1]-[10,18])circle(10);
   translate(holes[1]-[28,22])circle(6);
   translate(holes[0]+[28,22])circle(6);
    for (h = holes)      translate(h)circle(d=2.8);

}
linear_extrude(7)for (h = holes) {
    difference(){
      translate(h)offset(1)square([6,6],center=true);
      translate(h)circle(d=2.8);
    }
}
