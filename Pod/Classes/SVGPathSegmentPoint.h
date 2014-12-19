//
//  SVGPathSegmentPoint.h
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGPathSegment.h"

typedef NS_ENUM(NSUInteger, SVGPathSegmentPointType)
{
    SVGPathSegmentPointTypeRelative = 0,
    SVGPathSegmentPointTypeAbsolute = 1,
};

@interface SVGPathSegmentPoint : SVGPathSegment

- (instancetype)initWithPointType:(SVGPathSegmentPointType)type point:(SVGCoordinatePair)point;

@property (nonatomic, readonly) SVGPathSegmentPointType type;
@property (nonatomic, readonly) SVGCoordinatePair point;

@end
