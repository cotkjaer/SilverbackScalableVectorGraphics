//
//  SVGPathSegmentCurveToQuadratic.h
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGPathSegmentPoint.h"

@interface SVGPathSegmentCurveToQuadratic : SVGPathSegmentPoint

- (instancetype)initWithPointType:(SVGPathSegmentPointType)type point:(SVGCoordinatePair)point controlPoint:(SVGCoordinatePair)controlPoint;

@property (nonatomic, readonly) SVGCoordinatePair controlPoint;

@end
