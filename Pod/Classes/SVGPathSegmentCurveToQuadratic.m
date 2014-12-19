//
//  SVGPathSegmentCurveToQuadratic.m
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGPathSegmentCurveToQuadratic.h"

@implementation SVGPathSegmentCurveToQuadratic

- (instancetype)initWithPointType:(SVGPathSegmentPointType)type
                            point:(SVGCoordinatePair)point
                     controlPoint:(SVGCoordinatePair)controlPoint
{
    self = [super initWithPointType:type point:point];
    
    if (self)
    {
        _controlPoint = controlPoint;
    }
    
    return self;
}

- (SVGPathSegmentType)segmentType
{
    return (self.type == SVGPathSegmentPointTypeAbsolute) ? SVGPathSegmentType_CURVETO_QUADRATIC_ABS : SVGPathSegmentType_CURVETO_QUADRATIC_REL;
}

- (NSString *)segmentTypeLetter
{
    return (self.type == SVGPathSegmentPointTypeAbsolute) ? @"Q" : @"q";
}


@end
