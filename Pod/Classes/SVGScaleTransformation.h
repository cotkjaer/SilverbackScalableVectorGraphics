//
//  SVGScaleTransformation.h
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

#import "SVGTransformation.h"

@interface SVGScaleTransformation : SVGTransformation

@property (nonatomic) SVGFloat scaleFactor;

- (instancetype)initWithScaleFactor:(SVGFloat)scaleFactor;

@end
