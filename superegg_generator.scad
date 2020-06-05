// 2-3-2018

//superegg, note only returns top half
function superegg(x,n,a,b)
= b*pow( (1-pow( (x/a),n ) ), (1/n) );

//free parameters
sizeScale=20; //scales the size of the object
ratio=3/4; //ratio of a/b
n=2.5; // exponent
facets=100; //number of facets between the arc generated in the rotation
increment=0.01; //resolution between adjacent points on the curve


//generate array of points
range=ratio*sizeScale;

positivePoints = [for(a =[0:increment:range-increment])
     ( [a,superegg(a,n,ratio*sizeScale,sizeScale)] )];
negativePoints = [for(a =[0:increment:range-increment])
     ( [a,-superegg(a,n,ratio*sizeScale,sizeScale)] )];

//append this last point to the end to counter against floating point errors
newPositivePoints=concat(positivePoints,[[range,0]]);
newNegativePoints=concat(negativePoints,[[range,0]]);

//use array of points, to generate a solid of revolution using polygon, rotate extrude, and hull
 hull() rotate_extrude($fn=facets)  polygon( points=newPositivePoints);
 hull() rotate_extrude($fn=facets)  polygon( points=newNegativePoints);
