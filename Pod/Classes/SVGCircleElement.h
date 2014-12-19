//
//  SVGCircleElement.h
//  Pods
//
//  Created by Christian Otkjær on 18/12/14.
//
//

#import "SVGElement.h"

@class SVGCoordinate;
@class SVGLength;

@interface SVGCircleElement : SVGElement

/**
 The x-axis coordinate of the center of the circle.
 If the attribute is not specified, the effect is as if a value of "0" were specified.
 Animatable: yes.
 */
@property (nonatomic, readonly) SVGCoordinate * cx;

/**
 The y-axis coordinate of the center of the circle.
 If the attribute is not specified, the effect is as if a value of "0" were specified.
 Animatable: yes.
 */
@property (nonatomic, readonly) SVGCoordinate * cy;

/**
 The radius of the circle.
 A negative value is an error (see Error processing). A value of zero disables rendering of the element.
 Animatable: yes.
 */
@property (nonatomic, readonly) SVGLength * r;

@end
