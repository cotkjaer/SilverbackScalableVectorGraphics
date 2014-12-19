//
//  NSCharacterSet+SVG.m
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "NSCharacterSet+SVG.h"

@implementation NSCharacterSet (SVG)

/**
 wsp:
 (#x20 | #x9 | #xD | #xA)
 */
+ (NSCharacterSet *)SVGWhitespaceCharacterSet;
{
    static NSCharacterSet *svgWhitespaceCharacterSet = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        svgWhitespaceCharacterSet = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"%c%c%c%c", 0x20, 0x9, 0xD, 0xA]];
    });
    
    return svgWhitespaceCharacterSet;
}

+ (instancetype)SVGMoveToCommandCharacterSet
{
    return [NSCharacterSet characterSetWithCharactersInString:@"Mm"];
}

+ (instancetype)SVGCloseCommandCharacterSet
{
    return [NSCharacterSet characterSetWithCharactersInString:@"Zz"];
}

+ (instancetype)SVGLineToCommandCharacterSet
{
    return [NSCharacterSet characterSetWithCharactersInString:@"Ll"];
}

+ (instancetype)SVGHorizontalLineToCommandCharacterSet
{
    return [NSCharacterSet characterSetWithCharactersInString:@"Hh"];
}

+ (instancetype)SVGVerticalLineToCommandCharacterSet
{
    return [NSCharacterSet characterSetWithCharactersInString:@"Vv"];
}

+ (instancetype)SVGCurveToCommandCharacterSet
{
    return [NSCharacterSet characterSetWithCharactersInString:@"Cc"];
}

+ (instancetype)SVGSmoothCurveToCommandCharacterSet
{
    return [NSCharacterSet characterSetWithCharactersInString:@"Ss"];
}

+ (instancetype)SVGQuadraticCurveToCommandCharacterSet
{
    return [NSCharacterSet characterSetWithCharactersInString:@"Qq"];
}

+ (instancetype)SVGSmoothQuadraticCurveToCommandCharacterSet
{
    return [NSCharacterSet characterSetWithCharactersInString:@"Tt"];
}

+ (instancetype)SVGellipticalArcCommandCharacterSet
{
    return [NSCharacterSet characterSetWithCharactersInString:@"Aa"];
}

+ (instancetype)SVGDrawtoCommandsCharacterSet
{
    return [NSCharacterSet characterSetWithCharactersInString:@"LlVvHhCcSsQqTtAaZz"];
}



@end
