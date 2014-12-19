//
//  SVGPathElement.h
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGElement.h"

@class SVGPathSegment;

@interface SVGPathElement : SVGElement <NSMutableCopying, NSCopying>

@property (nonatomic, readonly) NSArray * pathSegments;

@end

@interface SVGMutablePathElement : SVGPathElement

- (void)addPathSegment:(SVGPathSegment *)pathSegment;

@end