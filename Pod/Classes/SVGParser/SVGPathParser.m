//
//  SVGPathAndPointParser.m
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGPathParser.h"

#import "NSCharacterSet+SVG.h"
#import "SVGPathElement.h"
#import "SVGPathSegment.h"

@implementation SVGPathParser


- (BOOL)parsePathSegmenetsIn:(SVGMutablePathElement *)path
{
    NSString * pathString = path.attributes[@"d"];
    
    if (pathString)
    {
        NSScanner * scanner = [NSScanner scannerWithString:pathString];
        
        return [self readSvgPath:scanner intoPath:path];
    }
    
    return NO;
}
/*
 svg-path:
 wsp* moveto-drawto-command-groups? wsp*
 */
- (BOOL)readSvgPath:(NSScanner *)scanner intoPath:(SVGMutablePathElement *)path
{
    [self sinkWhitespaces:scanner];
    
    if ([self readMovetoDrawtoCommandGroups:scanner path:path])
    {
        [self sinkWhitespaces:scanner];
        
        return scanner.isAtEnd;
    }
    
    return NO;
}


/*
 http://www.w3.org/TR/2011/REC-SVG11-20110816/paths.html#PathDataBNF
 svg-path:
 wsp* moveto-drawto-command-groups? wsp*
 moveto-drawto-command-groups:
 moveto-drawto-command-group
 | moveto-drawto-command-group wsp* moveto-drawto-command-groups
 moveto-drawto-command-group:
 moveto wsp* drawto-commands?
 drawto-commands:
 drawto-command
 | drawto-command wsp* drawto-commands
 drawto-command:
 closepath
 | lineto
 | horizontal-lineto
 | vertical-lineto
 | curveto
 | smooth-curveto
 | quadratic-bezier-curveto
 | smooth-quadratic-bezier-curveto
 | elliptical-arc
 moveto:
 ( "M" | "m" ) wsp* moveto-argument-sequence
 moveto-argument-sequence:
 coordinate-pair
 | coordinate-pair comma-wsp? lineto-argument-sequence
 closepath:
 ("Z" | "z")
 lineto:
 ( "L" | "l" ) wsp* lineto-argument-sequence
 lineto-argument-sequence:
 coordinate-pair
 | coordinate-pair comma-wsp? lineto-argument-sequence
 horizontal-lineto:
 ( "H" | "h" ) wsp* horizontal-lineto-argument-sequence
 horizontal-lineto-argument-sequence:
 coordinate
 | coordinate comma-wsp? horizontal-lineto-argument-sequence
 vertical-lineto:
 ( "V" | "v" ) wsp* vertical-lineto-argument-sequence
 vertical-lineto-argument-sequence:
 coordinate
 | coordinate comma-wsp? vertical-lineto-argument-sequence
 curveto:
 ( "C" | "c" ) wsp* curveto-argument-sequence
 curveto-argument-sequence:
 curveto-argument
 | curveto-argument comma-wsp? curveto-argument-sequence
 curveto-argument:
 coordinate-pair comma-wsp? coordinate-pair comma-wsp? coordinate-pair
 smooth-curveto:
 ( "S" | "s" ) wsp* smooth-curveto-argument-sequence
 smooth-curveto-argument-sequence:
 smooth-curveto-argument
 | smooth-curveto-argument comma-wsp? smooth-curveto-argument-sequence
 smooth-curveto-argument:
 coordinate-pair comma-wsp? coordinate-pair
 quadratic-bezier-curveto:
 ( "Q" | "q" ) wsp* quadratic-bezier-curveto-argument-sequence
 quadratic-bezier-curveto-argument-sequence:
 quadratic-bezier-curveto-argument
 | quadratic-bezier-curveto-argument comma-wsp?
 quadratic-bezier-curveto-argument-sequence
 quadratic-bezier-curveto-argument:
 coordinate-pair comma-wsp? coordinate-pair
 smooth-quadratic-bezier-curveto:
 ( "T" | "t" ) wsp* smooth-quadratic-bezier-curveto-argument-sequence
 smooth-quadratic-bezier-curveto-argument-sequence:
 coordinate-pair
 | coordinate-pair comma-wsp? smooth-quadratic-bezier-curveto-argument-sequence
 elliptical-arc:
 ( "A" | "a" ) wsp* elliptical-arc-argument-sequence
 elliptical-arc-argument-sequence:
 elliptical-arc-argument
 | elliptical-arc-argument comma-wsp? elliptical-arc-argument-sequence
 elliptical-arc-argument:
 nonnegative-number comma-wsp? nonnegative-number comma-wsp?
 number comma-wsp flag comma-wsp? flag comma-wsp? coordinate-pair
 coordinate-pair:
 coordinate comma-wsp? coordinate
 coordinate:
 number
 nonnegative-number:
 integer-constant
 | floating-point-constant
 number:
 sign? integer-constant
 | sign? floating-point-constant
 flag:
 "0" | "1"
 comma-wsp:
 (wsp+ comma? wsp*) | (comma wsp*)
 comma:
 ","
 integer-constant:
 digit-sequence
 floating-point-constant:
 fractional-constant exponent?
 | digit-sequence exponent
 fractional-constant:
 digit-sequence? "." digit-sequence
 | digit-sequence "."
 exponent:
 ( "e" | "E" ) sign? digit-sequence
 sign:
 "+" | "-"
 digit-sequence:
 digit
 | digit digit-sequence
 digit:
 "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
 */

/*
 http://www.w3.org/TR/2011/REC-SVG11-20110816/shapes.html#PointsBNF
 
 list-of-points:
 wsp* coordinate-pairs? wsp*
 coordinate-pairs:
 coordinate-pair
 | coordinate-pair comma-wsp coordinate-pairs
 coordinate-pair:
 coordinate comma-wsp coordinate
 | coordinate negative-coordinate
 coordinate:
 number
 number:
 sign? integer-constant
 | sign? floating-point-constant
 negative-coordinate:
 "-" integer-constant
 | "-" floating-point-constant
 comma-wsp:
 (wsp+ comma? wsp*) | (comma wsp*)
 comma:
 ","
 integer-constant:
 digit-sequence
 floating-point-constant:
 fractional-constant exponent?
 | digit-sequence exponent
 fractional-constant:
 digit-sequence? "." digit-sequence
 | digit-sequence "."
 exponent:
 ( "e" | "E" ) sign? digit-sequence
 sign:
 "+" | "-"
 digit-sequence:
 digit
 | digit digit-sequence
 digit:
 "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
 */

/**
 wsp:
 (#x20 | #x9 | #xD | #xA)
 */
- (BOOL)sinkWhitespaces:(NSScanner*)scanner
{
    return [scanner scanCharactersFromSet:[NSCharacterSet SVGWhitespaceCharacterSet]
                               intoString:NULL];
}

/**
 comma-wsp:
 (wsp+ comma? wsp*) | (comma wsp*)
 comma:
 ","
 */
- (BOOL)sinkCommaAndWhitespaces:(NSScanner*)scanner
{
    if ([self sinkWhitespaces:scanner])
    {
        [scanner scanString:@"," intoString:NULL];
        [self sinkWhitespaces:scanner];
        
        return YES;
    }
    else
    {
        if ([scanner scanString:@"," intoString:NULL])
        {
            [self sinkWhitespaces:scanner];
            
            return YES;
        }
    }
    
    return NO;
}

/**
 moveto-drawto-command-groups:
 moveto-drawto-command-group
 | moveto-drawto-command-group wsp* moveto-drawto-command-groups
 */
- (BOOL)readMovetoDrawtoCommandGroups:(NSScanner*)scanner
                                 path:(SVGMutablePathElement *)path
{
    BOOL didRead = NO;
    
    if ([self readMovetoDrawtoCommandGroup:scanner path:path])
    {
        [self sinkWhitespaces:scanner];
        
        didRead = YES;
        
        if (![scanner isAtEnd])
        {
            [self sinkWhitespaces:scanner];
            
            didRead = [self readMovetoDrawtoCommandGroups:scanner path:path];
        }
    }
    
    return didRead;
}

/** moveto-drawto-command-group:
 moveto wsp* drawto-commands?
 */
- (BOOL)readMovetoDrawtoCommandGroup:(NSScanner*)scanner
                                path:(SVGMutablePathElement *)path
{
    if ([self readMoveto:scanner path:path])
    {
        [self sinkWhitespaces:scanner];
        
        [self readDrawtoCommands:scanner path:path];
        
        return YES;
    }
    
    return NO;
}

/**
 moveto:
 ( "M" | "m" ) wsp* moveto-argument-sequence
 */
- (BOOL)readMoveto:(NSScanner*)scanner path:(SVGMutablePathElement *)path
{
    NSString* cmd = nil;
    
    if ([scanner scanCharactersFromSet:[NSCharacterSet SVGMoveToCommandCharacterSet]intoString:&cmd])
    {
        [self sinkWhitespaces:scanner];
        
        NSMutableArray * coordinatePairSequence = [NSMutableArray new];
        
        [self readMovetoArgumentSequence:scanner intoCoordinatePairSequence:coordinatePairSequence];
        
        if (coordinatePairSequence.count > 0)
        {
            SVGPathSegment * segment = [SVGPathSegment pathSegmentWithCommand:cmd andCoordinatePairSequence:coordinatePairSequence];
            
            if (segment)
            {
                [path addPathSegment:segment];
                
                return YES;
            }
        }
    }
    
    return NO;
}

/** moveto-argument-sequence:
 coordinate-pair
 | coordinate-pair comma-wsp? lineto-argument-sequence
 */
- (BOOL)readMovetoArgumentSequence:(NSScanner*)scanner intoCoordinatePairSequence:(NSMutableArray *)coordinatePairSequence
{
    return [self readLinetoArgumentSequence:scanner intoCoordinatePairSequence:coordinatePairSequence];
}

/**
 drawto-commands:
 drawto-command
 | drawto-command wsp* drawto-commands
 */
- (BOOL)readDrawtoCommands:(NSScanner*)scanner
                      path:(SVGMutablePathElement *)path
{
    if ([self readDrawtoCommand:scanner path:path])
    {
        [self sinkWhitespaces:scanner];
        
        [self readDrawtoCommands:scanner path:path];
        
        return YES;
    }
    
    return NO;
}

/**
 drawto-command:
 closepath
 | lineto
 | horizontal-lineto
 | vertical-lineto
 | curveto
 | smooth-curveto
 | quadratic-bezier-curveto
 | smooth-quadratic-bezier-curveto
 | elliptical-arc
 */
- (BOOL)readDrawtoCommand:(NSScanner*)scanner
                     path:(SVGMutablePathElement *)path
{
    NSString * command = nil;
    
    NSUInteger scanLocation = scanner.scanLocation;
    
    if ([scanner scanCharactersFromSet:[NSCharacterSet SVGDrawtoCommandsCharacterSet]
                        intoString:&command])
    {
        if (command.length == 1)
        {
            scanner.scanLocation = scanLocation;
            char cmd = [command characterAtIndex:0];
            
            switch (cmd)
            {
                case 'L':
                case 'l':
                    return [self readLinetoCommand:scanner path:path];
                    break;
                    
                case 'h':
                case 'H':
                    return [self readHorizontalLinetoCommand:scanner path:path];
                    
                case 'C':
                case 'c':
                    return [self readCurvetoCommand:scanner path:path];
                    
                case 'S':
                case 's':
                    return [self readSmoothCurvetoCommand:scanner path:path];
                    
                case 'Q':
                case 'q':
                    return [self readQuadraticCurvetoCommand:scanner path:path];

                case 'T':
                case 't':
                    return [self readSmoothQuadraticCurvetoCommand:scanner path:path];
                    
                case 'A':
                case 'a':
                    return [self readEllipticalArcCommand:scanner path:path];
                    
                case 'Z':
                case 'z':
                    return [self readCloseCommand:scanner path:path];
                    
                default:
                    NSAssert(NO, @"implement");
                    break;
            }
        }
    }
    
    return NO;
}



/**
 coordinate-pair:
 coordinate comma-wsp? coordinate
 */

- (BOOL)readCoordinatePair:(NSScanner*)scanner intoCoordinatePairSequence:(NSMutableArray *)coordinatePairSequence
{
    SVGFloat x;
    if ([self readCoordinate:scanner intoFloat:&x])
    {
        [self sinkCommaAndWhitespaces:scanner];
        
        SVGFloat y;
        if ([self readCoordinate:scanner intoFloat:&y])
        {
            [coordinatePairSequence addObject:@(x)];
            [coordinatePairSequence addObject:@(y)];
            
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)readCoordinate:(NSScanner*)scanner
             intoFloat:(SVGFloat *)floatPointer
{
    return [scanner scanFloat:floatPointer];
}



/**
 lineto:
 ( "L" | "l" ) wsp* lineto-argument-sequence
 */
- (BOOL)readLinetoCommand:(NSScanner*)scanner
                     path:(SVGMutablePathElement *)path
{
    NSString* cmd = nil;
    
    if([scanner scanCharactersFromSet:[NSCharacterSet SVGLineToCommandCharacterSet] intoString:&cmd])
    {
        [self sinkWhitespaces:scanner];
        
        NSMutableArray * coordinatePairSequence = [NSMutableArray new];
        [self readLinetoArgumentSequence:scanner intoCoordinatePairSequence:coordinatePairSequence];
    }
    
    return NO;
}

/**
 lineto-argument-sequence:
 coordinate-pair
 | coordinate-pair comma-wsp? lineto-argument-sequence
 */
- (BOOL)readLinetoArgumentSequence:(NSScanner*)scanner intoCoordinatePairSequence:(NSMutableArray *)coordinatePairSequence
{
    if ([self readCoordinatePair:scanner intoCoordinatePairSequence:coordinatePairSequence])
    {
        [self sinkCommaAndWhitespaces:scanner];
        
        [self readLinetoArgumentSequence:scanner intoCoordinatePairSequence:coordinatePairSequence];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)readGenericQuadraticCurvetoCommand:(NSScanner*)scanner
                                      path:(SVGMutablePathElement *)path
                       commandCharacterSet:(NSCharacterSet *)commandCharacterSet
{
    NSString* cmd = nil;
    
    if([scanner scanCharactersFromSet:commandCharacterSet intoString:&cmd])
    {
        [self sinkWhitespaces:scanner];
        
        NSMutableArray * coordinatePairSequence = [NSMutableArray new];
        
        [self readQuadraticCurvetoArgumentSequence:scanner intoCoordinatePairSequence:coordinatePairSequence];
        
        if (coordinatePairSequence.count > 1)
        {
            SVGPathSegment * pathSegment = [SVGPathSegment pathSegmentWithCommand:cmd andCoordinatePairSequence:coordinatePairSequence];
            
            if (pathSegment)
            {
                [path addPathSegment:pathSegment];
                
                return YES;
            }
        }
    }
    return NO;
}

/**
 quadratic-bezier-curveto:
 ( "Q" | "q" ) wsp* quadratic-bezier-curveto-argument-sequence
 */
- (BOOL)readQuadraticCurvetoCommand:(NSScanner*)scanner
                               path:(SVGMutablePathElement *)path
{
    return [self readGenericQuadraticCurvetoCommand:scanner path:path commandCharacterSet:[NSCharacterSet SVGQuadraticCurveToCommandCharacterSet]];
}
/**
 quadratic-bezier-curveto-argument-sequence:
 quadratic-bezier-curveto-argument
 | quadratic-bezier-curveto-argument comma-wsp? quadratic-bezier-curveto-argument-sequence
 */
- (BOOL)readQuadraticCurvetoArgumentSequence:(NSScanner*)scanner
                  intoCoordinatePairSequence:(NSMutableArray *)coordinatePairSequence
{
    if ([self readQuadraticCurvetoArgument:scanner intoCoordinatePairSequence:coordinatePairSequence])
    {
        [self sinkCommaAndWhitespaces:scanner];
        
        [self readQuadraticCurvetoArgumentSequence:scanner intoCoordinatePairSequence:coordinatePairSequence];
        
        return YES;
    }
    
    return NO;
}

/**
 quadratic-bezier-curveto-argument:
 coordinate-pair comma-wsp? coordinate-pair
 */
- (BOOL)readQuadraticCurvetoArgument:(NSScanner*)scanner
          intoCoordinatePairSequence:(NSMutableArray *)coordinatePairSequence
{
    if ([self readCoordinatePair:scanner intoCoordinatePairSequence:coordinatePairSequence])
    {
        [self sinkCommaAndWhitespaces:scanner];
        
        if ([self readCoordinatePair:scanner intoCoordinatePairSequence:coordinatePairSequence])
        {
            return YES;
        }
    }
    
    return NO;
}

/**
 elliptical-arc:
 ( "A" | "a" ) wsp* elliptical-arc-argument-sequence
*/
- (BOOL)readEllipticalArcCommand:(NSScanner*)scanner path:(SVGMutablePathElement *)path
{
    NSString* cmd = nil;
    
    if ([scanner scanCharactersFromSet:[NSCharacterSet SVGellipticalArcCommandCharacterSet] intoString:&cmd])
    {
        [self sinkWhitespaces:scanner];
        
        NSMutableArray * coordinateSequence = [NSMutableArray new];
        
        if ([self readEllipticalArcArgumentSequence:scanner intoCoordinatePairSequence:coordinateSequence])
        {
            [path addPathSegment:[SVGPathSegment pathSegmentWithCommand:cmd andCoordinatePairSequence:coordinateSequence]];
    
        return YES;
        }
    }
    
    return NO;
}

/**
 elliptical-arc-argument-sequence:
 elliptical-arc-argument
 | elliptical-arc-argument comma-wsp? elliptical-arc-argument-sequence
 */
- (BOOL)readEllipticalArcArgumentSequence:(NSScanner*)scanner
         intoCoordinatePairSequence:(NSMutableArray *)coordinatePairSequence
{
    if ([self readEllipticalArcArgument:scanner intoCoordinatePairSequence:coordinatePairSequence])
    {
        [self sinkCommaAndWhitespaces:scanner];
        
        [self readEllipticalArcArgumentSequence:scanner intoCoordinatePairSequence:coordinatePairSequence];
        
        return YES;
    }
    
    return NO;
}

/**
 elliptical-arc-argument:
 nonnegative-number comma-wsp? nonnegative-number comma-wsp? number comma-wsp flag comma-wsp? flag comma-wsp? coordinate-pair

 SHOULD IT BE:
 nonnegative-number comma-wsp? nonnegative-number comma-wsp? number comma-wsp? flag comma-wsp? flag comma-wsp? coordinate-pair
*/
- (BOOL)readEllipticalArcArgument:(NSScanner*)scanner
 intoCoordinatePairSequence:(NSMutableArray *)coordinatePairSequence
{
    // TODO read nonnegative-number
    
    SVGFloat nonNegativeNumber1;

    if ([self readCoordinate:scanner intoFloat:&nonNegativeNumber1])
    {
        [self sinkCommaAndWhitespaces:scanner];
        
        SVGFloat nonNegativeNumber2;
        
        if ([self readCoordinate:scanner intoFloat:&nonNegativeNumber2])
        {
            [self sinkCommaAndWhitespaces:scanner];
            
            SVGFloat number;
            
            if ([self readCoordinate:scanner intoFloat:&number])
            {
                // This is where the potential missing '?' in the BNF acts
                if ([self sinkCommaAndWhitespaces:scanner])
                {
                    BOOL flag1;
                    
                    if ([self readFlag:scanner into:&flag1])
                    {
                        [self sinkCommaAndWhitespaces:scanner];
                        
                        BOOL flag2;
                        
                        if ([self readFlag:scanner into:&flag2])
                        {
                            [self sinkCommaAndWhitespaces:scanner];
                            
                            SVGFloat x;
                            
                            if ([self readCoordinate:scanner intoFloat:&x])
                            {
                                [self sinkCommaAndWhitespaces:scanner];
                                
                                SVGFloat y;
                                
                                if ([self readCoordinate:scanner intoFloat:&y])
                                {
                                    [coordinatePairSequence addObjectsFromArray:@[@(nonNegativeNumber1), @(nonNegativeNumber2), @(number), @(flag1), @(flag2), @(x), @(y)]];
                                    
                                    return YES;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    return NO;
}

/**
 flag:
 '1' | '0'
 */
- (BOOL)readFlag:(NSScanner*)scanner into:(BOOL *)flag
{
    NSString * flagString;
    
    if ([scanner scanCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"10"] intoString:&flagString])
    {
        if (flagString.length == 1)
        {
            *flag = [flagString isEqualToString:@"1"];
            
            return YES;
        }
    }

    return NO;
}

/**
 smooth-quadratic-bezier-curveto:
 ( "T" | "t" ) wsp* smooth-quadratic-bezier-curveto-argument-sequence
 */
- (BOOL)readSmoothQuadraticCurvetoCommand:(NSScanner*)scanner path:(SVGMutablePathElement *)path
{
    return [self readGenericQuadraticCurvetoCommand:scanner
                                               path:path
                                commandCharacterSet:[NSCharacterSet SVGSmoothQuadraticCurveToCommandCharacterSet]];
}

///**
// smooth-quadratic-bezier-curveto-argument-sequence:
// smooth-quadratic-bezier-curveto-argument
// | smooth-quadratic-bezier-curveto-argument comma-wsp? smooth-quadratic-bezier-curveto-argument-sequence
// */
//- (BOOL)readSmoothQuadraticCurvetoArgumentSequence:(NSScanner*)scanner path:(SVGMutablePathElement *)path
//{
//
//    SVGCurve curve = [self readSmoothQuadraticCurvetoArgument:scanner path:path relativeTo:origin withPrevCurve:prevCurve];
//
//    if (![scanner isAtEnd]) {
//        curve = [self readSmoothQuadraticCurvetoArgumentSequence:scanner path:path relativeTo:origin withPrevCurve:prevCurve];
//    }
//
//    return curve;
//}
//
///**
// smooth-quadratic-bezier-curveto-argument:
// coordinate-pair comma-wsp? coordinate-pair
// */
//- (BOOL)readSmoothQuadraticCurvetoArgument:(NSScanner*)scanner path:(SVGMutablePathElement *)path
//{
//    CGPoint p1 = [self readCoordinatePair:scanner];
//    CGPoint coord1 = CGPointMake(p1.x+origin.x, p1.y+origin.y);
//    [self readCommaAndWhitespace:scanner];
//
//    SVGCurve thisCurve = SVGCurveZero;
//    if (SVGCurveEqualToCurve(SVGCurveZero, prevCurve)) {
//        // assume control point is coincident with the current point
//        thisCurve = SVGCurveMake(coord1.x, coord1.y, 0.0f, 0.0f, thisCurve.p.x, thisCurve.p.y);
//    } else {
//        // calculate the mirror of the previous control point
//        CGPoint currentPoint = prevCurve.p;
//        CGPoint controlPoint = prevCurve.c1;
//        CGPoint mirrorCoord = CGPointMake(currentPoint.x+(currentPoint.x-controlPoint.x), currentPoint.y+(currentPoint.y-controlPoint.y));
//        thisCurve = SVGCurveMake(mirrorCoord.x, mirrorCoord.y, 0.0f, 0.0f, coord1.x, coord1.y);
//    }
//
//    CGPathAddQuadCurveToPoint(path, NULL, thisCurve.c1.x, thisCurve.c1.y, thisCurve.p.x, thisCurve.p.y );
//#if DEBUG_PATH_CREATION
//    DDLogCWarn(@"[%@] PATH: SMOOTH QUADRATIC CURVE to (%2.2f, %2.2f)..(%2.2f, %2.2f)", [self class], thisCurve.c1.x, thisCurve.c1.y, thisCurve.p.x, thisCurve.p.y );
//#endif
//
//    return thisCurve;
//}
//
/**
 curveto:
 ( "C" | "c" ) wsp* curveto-argument-sequence
 */
- (BOOL)readCurvetoCommand:(NSScanner*)scanner
                      path:(SVGMutablePathElement *)path
{
    NSString* cmd = nil;
    
    if ([scanner scanCharactersFromSet:[NSCharacterSet SVGCurveToCommandCharacterSet] intoString:&cmd])
    {
        [self sinkWhitespaces:scanner];
        
        NSMutableArray * coordinateSequence = [NSMutableArray new];
        
        if ([self readCurvetoArgumentSequence:scanner intoCoordinatePairSequence:coordinateSequence])
        {
            [path addPathSegment:[SVGPathSegment pathSegmentWithCommand:cmd andCoordinatePairSequence:coordinateSequence]];

            return YES;
        };
    }
    
    return NO;
}

/**
 curveto-argument-sequence:
 curveto-argument
 | curveto-argument comma-wsp? curveto-argument-sequence
 */
- (BOOL)readCurvetoArgumentSequence:(NSScanner*)scanner
         intoCoordinatePairSequence:(NSMutableArray *)coordinatePairSequence
{
    if ([self readCurvetoArgument:scanner intoCoordinatePairSequence:coordinatePairSequence])
    {
        [self sinkCommaAndWhitespaces:scanner];
        
        [self readCurvetoArgumentSequence:scanner intoCoordinatePairSequence:coordinatePairSequence];
        
        return YES;
    }
    
    return NO;
}

/**
 curveto-argument:
 coordinate-pair comma-wsp? coordinate-pair comma-wsp? coordinate-pair
 */
- (BOOL)readCurvetoArgument:(NSScanner*)scanner
 intoCoordinatePairSequence:(NSMutableArray *)coordinatePairSequence
{
    if ([self readCoordinatePair:scanner intoCoordinatePairSequence:coordinatePairSequence])
    {
        [self sinkCommaAndWhitespaces:scanner];
        
        if ([self readCoordinatePair:scanner intoCoordinatePairSequence:coordinatePairSequence])
        {
            [self sinkCommaAndWhitespaces:scanner];
        
            if ([self readCoordinatePair:scanner intoCoordinatePairSequence:coordinatePairSequence])
            {
                return YES;
            }
        }
    }
    
    return NO;
    
    //    SVGCurve curveResult;
    //    curveResult.c1 = [self readCoordinatePair:scanner];
    //    curveResult.c1.x += origin.x; // avoid allocating a new struct, an allocation here could happen MILLIONS of times in a large parse!
    //    curveResult.c1.y += origin.y;
    //    [self readCommaAndWhitespace:scanner];
    //
    //    curveResult.c2 = [self readCoordinatePair:scanner];
    //    curveResult.c2.x += origin.x; // avoid allocating a new struct, an allocation here could happen MILLIONS of times in a large parse!
    //    curveResult.c2.y += origin.y;
    //    [self readCommaAndWhitespace:scanner];
    //
    //    curveResult.p = [self readCoordinatePair:scanner];
    //    curveResult.p.x += origin.x; // avoid allocating a new struct, an allocation here could happen MILLIONS of times in a large parse!
    //    curveResult.p.y += origin.y;
    //    [self readCommaAndWhitespace:scanner];
    //
    //    CGPathAddCurveToPoint(path, NULL, curveResult.c1.x, curveResult.c1.y, curveResult.c2.x, curveResult.c2.y, curveResult.p.x, curveResult.p.y);
    //#if DEBUG_PATH_CREATION
    //    DDLogCWarn(@"[%@] PATH: CURVE to (%2.2f, %2.2f)..(%2.2f, %2.2f)..(%2.2f, %2.2f)", [self class], curveResult.c1.x, curveResult.c1.y, curveResult.c2.x, curveResult.c2.y, curveResult.p.x, curveResult.p.y);
    //#endif
    //
    //    return curveResult;
    
    return NO;
}

/**
 smooth-curveto:
 ( "S" | "s" ) wsp* smooth-curveto-argument-sequence
 */
- (BOOL)readSmoothCurvetoCommand:(NSScanner*)scanner path:(SVGMutablePathElement *)path
{
    NSString* cmd = nil;
    
    if ([scanner scanCharactersFromSet:[NSCharacterSet SVGSmoothCurveToCommandCharacterSet] intoString:&cmd])
    {
        [self sinkWhitespaces:scanner];
        
        NSMutableArray * coordinateSequence = [NSMutableArray new];
        
        [self readSmoothCurvetoArgumentSequence:scanner intoCoordinatePairSequence:coordinateSequence];
        
        return YES;
    }
    
    return NO;
}

/**
 smooth-curveto-argument-sequence:
 smooth-curveto-argument
 | smooth-curveto-argument comma-wsp? smooth-curveto-argument-sequence
 */
- (BOOL)readSmoothCurvetoArgumentSequence:(NSScanner*)scanner
               intoCoordinatePairSequence:(NSMutableArray *)coordinatePairSequence

{
    if ([self readSmoothCurvetoArgument:scanner intoCoordinatePairSequence:coordinatePairSequence])
    {
        [self sinkCommaAndWhitespaces:scanner];
        
        [self readSmoothCurvetoArgumentSequence:scanner intoCoordinatePairSequence:coordinatePairSequence];
        
        return YES;
    }
    
    return NO;
}

/**
 smooth-curveto-argument:
 coordinate-pair comma-wsp? coordinate-pair
 */
- (BOOL)readSmoothCurvetoArgument:(NSScanner*)scanner
       intoCoordinatePairSequence:(NSMutableArray *)coordinatePairSequence
{
    if ([self readCoordinatePair:scanner intoCoordinatePairSequence:coordinatePairSequence])
    {
        [self sinkCommaAndWhitespaces:scanner];
        
        if ([self readCoordinatePair:scanner intoCoordinatePairSequence:coordinatePairSequence])
        {
            return YES;
        }
    }
    
    return NO;
}

/**
 vertical-lineto-argument-sequence:
 coordinate
 | coordinate comma-wsp? vertical-lineto-argument-sequence
 */
/**
 horizontal-lineto-argument-sequence:
 coordinate
 | coordinate comma-wsp? horizontal-lineto-argument-sequence
 */
/**
 single-coordinate-argument-sequence:
 coordinate
 | coordinate comma-wsp? single-coordinate-argument-sequence:
 */
- (BOOL)readSingleCoordinateArgumentSequence:(NSScanner*)scanner
                  intoCoordinatePairSequence:(NSMutableArray *)coordinatePairSequence
{
    SVGFloat coordinate;
    
    if ([self readCoordinate:scanner intoFloat:&coordinate])
    {
        [coordinatePairSequence addObject:@(coordinate)];
        
        [self sinkCommaAndWhitespaces:scanner];
        
        [self readSingleCoordinateArgumentSequence:scanner intoCoordinatePairSequence:coordinatePairSequence];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)readSingleCoordinateArgumentsCommandWithFormat:(NSCharacterSet *)commandFormat
                                               scanner:(NSScanner *)scanner
                                                  path:(SVGMutablePathElement *)path
{
    NSString* command = nil;
    
    if ([scanner scanCharactersFromSet:commandFormat intoString:&command])
    {
        [self sinkWhitespaces:scanner];
        
        NSMutableArray * coordinateSequence = [NSMutableArray new];
        
        if ([self readSingleCoordinateArgumentSequence:scanner intoCoordinatePairSequence:coordinateSequence])
        {
            [path addPathSegment:[SVGPathSegment pathSegmentWithCommand:command andCoordinatePairSequence:coordinateSequence]];
            
            return YES;
        }
    }
    
    return NO;
}

/**
 vertical-lineto:
 ( "V" | "v" ) wsp* vertical-lineto-argument-sequence
 */
- (BOOL)readVerticalLinetoCommand:(NSScanner*)scanner
                             path:(SVGMutablePathElement *)path
{
    return [self readSingleCoordinateArgumentsCommandWithFormat:[NSCharacterSet characterSetWithCharactersInString:@"Vv"] scanner:scanner path:path];
}

/**
 horizontal-lineto:
 ( "H" | "h" ) wsp* horizontal-lineto-argument-sequence
 */
- (BOOL)readHorizontalLinetoCommand:(NSScanner*)scanner
                               path:(SVGMutablePathElement *)path
{
    return [self readSingleCoordinateArgumentsCommandWithFormat:[NSCharacterSet characterSetWithCharactersInString:@"Hh"] scanner:scanner path:path];
}

- (BOOL)readCloseCommand:(NSScanner*)scanner
                    path:(SVGMutablePathElement *)path
{
    NSString* cmd = nil;
    
    if ([scanner scanCharactersFromSet:[NSCharacterSet SVGCloseCommandCharacterSet] intoString:&cmd])
    {
        [path addPathSegment:[SVGPathSegment pathSegmentWithCommand:cmd andCoordinatePairSequence:nil]];
        
        return YES;
    }
    
    return NO;
}



@end