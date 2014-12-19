//
//  NSCharacterSet+SVG.h
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import <Foundation/Foundation.h>

@interface NSCharacterSet (SVG)

+ (NSCharacterSet *)SVGWhitespaceCharacterSet;

+ (instancetype)SVGMoveToCommandCharacterSet;
+ (instancetype)SVGCloseCommandCharacterSet;
+ (instancetype)SVGLineToCommandCharacterSet;
+ (instancetype)SVGHorizontalLineToCommandCharacterSet;
+ (instancetype)SVGVerticalLineToCommandCharacterSet;
+ (instancetype)SVGCurveToCommandCharacterSet;
+ (instancetype)SVGSmoothCurveToCommandCharacterSet;
+ (instancetype)SVGQuadraticCurveToCommandCharacterSet;
+ (instancetype)SVGSmoothQuadraticCurveToCommandCharacterSet;
+ (instancetype)SVGellipticalArcCommandCharacterSet;
+ (instancetype)SVGDrawtoCommandsCharacterSet;

@end
