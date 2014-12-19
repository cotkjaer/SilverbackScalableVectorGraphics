//
//  SVGCoordinateSystem.m
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

#import "SVGCoordinateSystem.h"


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

- (SVGCoordinate *)convertCoordinate:(SVGCoordinate *)coordinate fromCoordinateSystem:(SVGCoordinateSystem *)system
{
    // TODO: implement CoordinateSystem hierarchy and transforms
    return coordinate;
}

- (SVGLength *)convertLength:(SVGLength *)length fromCoordinateSystem:(SVGCoordinateSystem *)system
{
    // TODO: implement CoordinateSystem hierarchy and transforms
    return length;
}


@end
