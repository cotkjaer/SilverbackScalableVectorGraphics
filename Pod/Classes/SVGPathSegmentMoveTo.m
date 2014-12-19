//
//  SVGPathSegmentMoveTo.m
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGPathSegmentMoveTo.h"

@implementation SVGPathSegmentMoveTo

- (SVGPathSegmentType)segmentType
{
    return (self.type == SVGPathSegmentPointTypeAbsolute) ? SVGPathSegmentType_MOVETO_ABS : SVGPathSegmentType_MOVETO_REL;
}

- (NSString *)segmentTypeLetter
{
    return (self.type == SVGPathSegmentPointTypeAbsolute) ? @"M" : @"m";
}

@end
