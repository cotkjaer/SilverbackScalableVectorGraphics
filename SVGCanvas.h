//
//  SVGCanvas.h
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

#import <Foundation/Foundation.h>

@class SVGCoordinateSystem;

/// "The space where SVG content is rendered." The canvas is infinite for each dimension of the space, but rendering occurs relative to a finite rectangular region of the canvas.
@interface SVGCanvas : NSObject

@property (nonatomic, strong) SVGCoordinateSystem * coordinateSystem;

@end
