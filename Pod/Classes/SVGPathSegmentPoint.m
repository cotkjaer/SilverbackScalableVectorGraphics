//
//  SVGPathSegmentPoint.m
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGPathSegmentPoint.h"

@implementation SVGPathSegmentPoint

- (instancetype)initWithPointType:(SVGPathSegmentPointType)type point:(SVGCoordinatePair)point
{
    self = [super init];
    
    if (self)
    {
        _type = type;
        _point = point;
    }
    
    return self;
}


@end
