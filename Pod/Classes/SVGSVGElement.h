//
//  SVGSVGElement.h
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGContainerElement.h"

@interface SVGSVGElement : SVGContainerElement

/**
 The x-axis coordinate of one corner of the rectangular region into which an embedded ‘svg’ element is placed. (Has no meaning or effect on outermost svg elements.)
 
 If the attribute is not specified, the effect is as if a value of '0' were specified.
 Animatable: yes.
 */
@property (nonatomic, readonly) SVGCoordinate * x;

/**
 The y-axis coordinate of one corner of the rectangular region into which an embedded ‘svg’ element is placed.  (Has no meaning or effect on outermost svg elements.)

 If the attribute is not specified, the effect is as if a value of '0' were specified.
 Animatable: yes.
 */
@property (nonatomic, readonly) SVGCoordinate * y;

/**
 For outermost svg elements, the intrinsic width of the SVG document fragment. For embedded ‘svg’ elements, the width of the rectangular region into which the ‘svg’ element is placed.
 A negative value is an error (see Error processing). A value of zero disables rendering of the element.
 If the attribute is not specified, the effect is as if a value of '100%' were specified.
 Animatable: yes.
 */
@property (nonatomic, readonly) SVGLength * width;

/**
 For outermost svg elements, the intrinsic height of the SVG document fragment. For embedded ‘svg’ elements, the height of the rectangular region into which the ‘svg’ element is placed.
 A negative value is an error (see Error processing). A value of zero disables rendering of the element.
 If the attribute is not specified, the effect is as if a value of '100%' were specified.
 Animatable: yes.
 */
@property (nonatomic, readonly) SVGLength * height;

/**
 Indicates the SVG language version to which this document fragment conforms.
 In SVG 1.0 [SVG10], this attribute was fixed to the value '1.0'. For SVG 1.1, the attribute should have the value '1.1'.
 Animatable: no.
*/
 @property (nonatomic, readonly) float version;

/*
 TODO:
 baseProfile = profile-name
Describes the minimum SVG language profile that the author believes is necessary to correctly render the content. The attribute does not specify any processing restrictions; It can be considered metadata. For example, the value of the attribute could be used by an authoring tool to warn the user when they are modifying the document beyond the scope of the specified base profile. Each SVG profile should define the text that is appropriate for this attribute.
If the attribute is not specified, the effect is as if a value of 'none' were specified.
Animatable: no.
 */

/*
 TODO:
preserveAspectRatio = "[defer] <align> [<meetOrSlice>]"
See ‘preserveAspectRatio’.

If the attribute is not specified, then the effect is as if a value of 'xMidYMid meet' were specified.

Animatable: yes.
*/

@end
