//
//  SVGTransformation.h
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

#import "SVGCoordinateSystem.h"

@interface SVGTransformation : NSObject

- (SVGCoordinate *)transformCoordinate:(SVGCoordinate *)coordinate;

- (SVGLength *)transformLength:(SVGLength *)length;

+ (instancetype)fromText:(NSString *)text;

@end
