//
//  SVGCoordinateSystem.m
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

#import "SVGCoordinateSystem.h"

#import "SVGTransformation.h"

@implementation SVGCoordinateSystem

- (instancetype)initWithParent:(SVGCoordinateSystem *)parent andTransformations:(NSArray *)transformations;
{
    self = [super init];
    
    if (self)
    {
        _parent = parent;
        _transformations = transformations;
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithParent:nil andTransformations:nil];
}

- (SVGCoordinate *)absoluteCoordinate:(SVGCoordinate *)coordinate
{
    if (self.transformations.count > 0)
    {
        __block SVGCoordinate * coord = coordinate;
        
        [self.transformations enumerateObjectsUsingBlock:^(SVGTransformation *transformation, NSUInteger idx, BOOL *stop)
         {
             coord = [transformation transformCoordinate:coord];
         }];
        return coord;
    }
    // TODO: implement CoordinateSystem hierarchy and transforms
    return coordinate;
}


- (SVGLength *)absoluteLength:(SVGLength *)length
{
    if (self.transformations.count > 0)
    {
        __block SVGLength * l = length;
        
        [self.transformations enumerateObjectsUsingBlock:^(SVGTransformation *transformation, NSUInteger idx, BOOL *stop)
         {
             l = [transformation transformLength:l];
         }];
        
        return l;
    }
    
    return length;
}

@end

inline CGRect CGRectMakeAtCenter(CGFloat cx, CGFloat cy, CGFloat width, CGFloat height)
{
    return CGRectMake(cx - width/2.f, cy-height/2.f, width, height);
}

inline CGRect CGRectMakeSquare(CGFloat ox, CGFloat oy, CGFloat side)
{
    return CGRectMake(ox, oy, side, side);
}

