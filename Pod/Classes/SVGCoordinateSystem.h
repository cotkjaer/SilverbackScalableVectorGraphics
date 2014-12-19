//
//  SVGCoordinateSystem.h
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

#import <Foundation/Foundation.h>

@class SVGTransformation;
@class SVGCoordinate;
@class SVGLength;

@interface SVGCoordinateSystem : NSObject

@property (nonatomic, readonly) SVGCoordinateSystem * parent;

@property (nonatomic, readonly) NSArray * transformations;

- (instancetype)initWithParent:(SVGCoordinateSystem *)parent andTransformations:(NSArray *)transformations;


- (SVGCoordinate *)convertCoordinate:(SVGCoordinate *)coordinate fromCoordinateSystem:(SVGCoordinateSystem *)system;



- (SVGLength *)convertLength:(SVGLength *)length fromCoordinateSystem:(SVGCoordinateSystem *)system;

@end
