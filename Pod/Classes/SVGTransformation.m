//
//  SVGTransformation.m
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

#import "SVGTransformation.h"

#import "SVGScaleTransformation.h"

/*
 The value of the ‘transform’ attribute is a <transform-list>, which is defined as a list of transform definitions, which are applied in the order provided. The individual transform definitions are separated by whitespace and/or a comma. The available types of transform definitions include:
 
 matrix(<a> <b> <c> <d> <e> <f>), which specifies a transformation in the form of a transformation matrix of six values. matrix(a,b,c,d,e,f) is equivalent to applying the transformation matrix [a b c d e f].
 
 translate(<tx> [<ty>]), which specifies a translation by tx and ty. If <ty> is not provided, it is assumed to be zero.
 
 scale(<sx> [<sy>]), which specifies a scale operation by sx and sy. If <sy> is not provided, it is assumed to be equal to <sx>.
 
 rotate(<rotate-angle> [<cx> <cy>]), which specifies a rotation by <rotate-angle> degrees about a given point.
 If optional parameters <cx> and <cy> are not supplied, the rotate is about the origin of the current user coordinate system. The operation corresponds to the matrix [cos(a) sin(a) -sin(a) cos(a) 0 0].
 If optional parameters <cx> and <cy> are supplied, the rotate is about the point (cx, cy). The operation represents the equivalent of the following specification: translate(<cx>, <cy>) rotate(<rotate-angle>) translate(-<cx>, -<cy>).
 
 skewX(<skew-angle>), which specifies a skew transformation along the x-axis.
 
 skewY(<skew-angle>), which specifies a skew transformation along the y-axis.
 
*/

@implementation SVGTransformation

- (SVGCoordinate *)transformCoordinate:(SVGCoordinate *)coordinate
{
    return coordinate;
}

- (SVGLength *)transformLength:(SVGLength *)length
{
    return length;
}

+ (instancetype)fromText:(NSString *)text
{
    NSScanner * scanner = [NSScanner scannerWithString:[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    if ([scanner scanString:@"scale(" intoString:nil])
    {
        float scaleFactor = 1.f;
        
        if ([scanner scanFloat:&scaleFactor])
        {
            if (scaleFactor != 1.f)
            {
                return [[SVGScaleTransformation alloc] initWithScaleFactor:scaleFactor];
            }
        }
    }
    
    return nil;
}

@end
