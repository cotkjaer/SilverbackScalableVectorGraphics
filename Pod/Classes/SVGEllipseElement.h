//
//  SVGEllipseElement.h
//  Pods
//
//  Created by Christian Otkjær on 17/12/14.
//
//

#import "SVGElement.h"

@interface SVGEllipseElement : SVGElement

/**
 The x-axis coordinate of the center of the ellipse.
 If the attribute is not specified, the effect is as if a value of "0" were specified.
 Animatable: yes.
 */
@property (nonatomic, readonly) SVGCoordinate * cx;

/**
 The y-axis coordinate of the center of the ellipse.
 If the attribute is not specified, the effect is as if a value of "0" were specified.
 Animatable: yes.
 */
@property (nonatomic, readonly) SVGCoordinate * cy;

/**
 The x-axis radius of the ellipse.
 A negative value is an error (see Error processing). A value of zero disables rendering of the element.
 Animatable: yes.
 */
@property (nonatomic, readonly) SVGLength * rx;

/**
 The y-axis radius of the ellipse.
 A negative value is an error (see Error processing). A value of zero disables rendering of the element.
 Animatable: yes.
 */
@property (nonatomic, readonly) SVGLength * ry;

@end
