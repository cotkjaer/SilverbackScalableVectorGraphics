//
//  SVGViewPort.h
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

#import <Foundation/Foundation.h>

@class SVGCoordinate;
@class SVGPoint;
@class SVGSize;

@protocol SVGViewPort <NSObject>

@property (nonatomic, strong) SVGPoint * origin;
@property (nonatomic, strong) SVGSize * size;

@end
