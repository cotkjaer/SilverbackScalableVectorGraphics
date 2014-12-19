//
//  SVGCoordinateSystem.h
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

#import <Foundation/Foundation.h>

@class SVGTransformation;

#import "SVGLength.h"
#import "SVGAngle.h"
#import "SVGCoordinate.h"

//#import "SVGPaint.h"
#import "SVGColor.h"

@interface SVGCoordinateSystem : NSObject

@property (nonatomic, readonly) SVGCoordinateSystem * parent;

@property (nonatomic, readonly) NSArray * transformations;

- (instancetype)initWithParent:(SVGCoordinateSystem *)parent
            andTransformations:(NSArray *)transformations;

/// transform the coordinate into topmost - parent coordinatesystem
- (SVGCoordinate *)absoluteCoordinate:(SVGCoordinate *)coordinate;

/// transform the length into topmost - parent coordinatesystem
- (SVGLength *)absoluteLength:(SVGLength *)length;

//- (void)addTransformation:(SVGTransformation *)transformation;

@end

CGRect CGRectMakeAtCenter(CGFloat cx, CGFloat cy, CGFloat width, CGFloat height);

CGRect CGRectMakeSquare(CGFloat ox, CGFloat oy, CGFloat side);

