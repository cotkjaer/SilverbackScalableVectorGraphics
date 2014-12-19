//
//  SVGPathElementSegment.h
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGValue.h"

typedef NS_ENUM(NSUInteger, SVGPathSegmentType)
{
    SVGPathSegmentType_UNKNOWN = 0,
    SVGPathSegmentType_CLOSEPATH = 1,
    SVGPathSegmentType_MOVETO_ABS = 2,
    SVGPathSegmentType_MOVETO_REL = 3,
    SVGPathSegmentType_LINETO_ABS = 4,
    SVGPathSegmentType_LINETO_REL = 5,
    SVGPathSegmentType_CURVETO_CUBIC_ABS = 6,
    SVGPathSegmentType_CURVETO_CUBIC_REL = 7,
    SVGPathSegmentType_CURVETO_QUADRATIC_ABS = 8,
    SVGPathSegmentType_CURVETO_QUADRATIC_REL = 9,
    SVGPathSegmentType_ARC_ABS = 10,
    SVGPathSegmentType_ARC_REL = 11,
    SVGPathSegmentType_LINETO_HORIZONTAL_ABS = 12,
    SVGPathSegmentType_LINETO_HORIZONTAL_REL = 13,
    SVGPathSegmentType_LINETO_VERTICAL_ABS = 14,
    SVGPathSegmentType_LINETO_VERTICAL_REL = 15,
    SVGPathSegmentType_CURVETO_CUBIC_SMOOTH_ABS = 16,
    SVGPathSegmentType_CURVETO_CUBIC_SMOOTH_REL = 17,
    SVGPathSegmentType_CURVETO_QUADRATIC_SMOOTH_ABS = 18,
    SVGPathSegmentType_CURVETO_QUADRATIC_SMOOTH_REL = 19,
};


@interface SVGPathSegment : NSObject

+ (instancetype)pathSegmentWithCommand:(NSString *)command andCoordinatePairSequence:(NSArray *)coordinatePairSequence;

@property (nonatomic, readonly) SVGPathSegmentType segmentType;

@property (nonatomic, readonly) NSString * segmentTypeLetter;

@property (nonatomic, readonly) NSString * segmentAsString;

@end
