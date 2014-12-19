//
//  SVGPathElementSegment.m
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGPathSegment.h"
#import "SVGPathSegmentMoveTo.h"

@interface SVGPathSegment ()

@property (nonatomic, strong) NSArray * coordinatePairSequence;

- (instancetype)initWithType:(SVGPathSegmentType)segmentType andCoordinatePairSequence:(NSArray *)coordinatePairSequence;

@end

@implementation SVGPathSegment

- (instancetype)initWithType:(SVGPathSegmentType)segmentType andCoordinatePairSequence:(NSArray *)coordinatePairSequence
{
    self = [super init];
    
    if (self)
    {
        _segmentType = segmentType;
        _coordinatePairSequence = [coordinatePairSequence copy];
    }
    
    return self;
}

- (NSString *)segmentTypeLetter
{
    switch (self.segmentType)
    {
        case SVGPathSegmentType_CLOSEPATH:
            return @"Z";
        case SVGPathSegmentType_MOVETO_ABS:
            return @"M";
        case SVGPathSegmentType_MOVETO_REL:
            return @"m";
        case SVGPathSegmentType_LINETO_ABS:
            return @"L";
        case SVGPathSegmentType_LINETO_REL:
            return @"l";
        case SVGPathSegmentType_CURVETO_CUBIC_ABS:
            return @"C";
        case SVGPathSegmentType_CURVETO_CUBIC_REL:
            return @"c";
        case SVGPathSegmentType_CURVETO_QUADRATIC_ABS:
            return @"Q";
        case SVGPathSegmentType_CURVETO_QUADRATIC_REL:
            return @"q";
        case SVGPathSegmentType_ARC_ABS:
            return @"A";
        case SVGPathSegmentType_ARC_REL:
            return @"a";
        case SVGPathSegmentType_LINETO_HORIZONTAL_ABS:
            return @"H";
        case SVGPathSegmentType_LINETO_HORIZONTAL_REL:
            return @"h";
        case SVGPathSegmentType_LINETO_VERTICAL_ABS:
            return @"V";
        case SVGPathSegmentType_LINETO_VERTICAL_REL:
            return @"v";
        case SVGPathSegmentType_CURVETO_CUBIC_SMOOTH_ABS:
            return @"S";
        case SVGPathSegmentType_CURVETO_CUBIC_SMOOTH_REL:
            return @"s";
        case SVGPathSegmentType_CURVETO_QUADRATIC_SMOOTH_ABS:
            return @"T";
        case SVGPathSegmentType_CURVETO_QUADRATIC_SMOOTH_REL:
            return @"t";
            
        default:
            return [NSString stringWithFormat:@"TODO %@", self];
            break;
    }
}

+ (SVGPathSegmentType)typeFromString:(NSString *)commandString
{    
    if (commandString.length == 1)
    {
        char cmd = [commandString characterAtIndex:0];
    
        switch (cmd)
        {
            case 'm':
                return SVGPathSegmentType_MOVETO_REL;
            case 'M':
                return SVGPathSegmentType_MOVETO_ABS;

            case 'l':
                return SVGPathSegmentType_LINETO_REL;
            case 'L':
                return SVGPathSegmentType_LINETO_ABS;
                
            case 'h':
                return SVGPathSegmentType_LINETO_HORIZONTAL_REL;
            case 'H':
                return SVGPathSegmentType_LINETO_HORIZONTAL_ABS;
                
            case 'c':
                return SVGPathSegmentType_CURVETO_CUBIC_REL;
            case 'C':
                return SVGPathSegmentType_CURVETO_CUBIC_ABS;
                
            case 's':
                return SVGPathSegmentType_CURVETO_CUBIC_SMOOTH_REL;
            case 'S':
                return SVGPathSegmentType_CURVETO_CUBIC_SMOOTH_ABS;
                
            case 'q':
                return SVGPathSegmentType_CURVETO_QUADRATIC_REL;
            case 'Q':
                return SVGPathSegmentType_CURVETO_QUADRATIC_ABS;
                
            case 't':
                return SVGPathSegmentType_CURVETO_QUADRATIC_SMOOTH_REL;
            case 'T':
                return SVGPathSegmentType_CURVETO_QUADRATIC_SMOOTH_ABS;
                
            case 'a':
                return SVGPathSegmentType_ARC_REL;
            case 'A':
                return SVGPathSegmentType_ARC_ABS;
                
            case 'z':
            case 'Z':
                return SVGPathSegmentType_CLOSEPATH;
                
            default:
                NSLog(@"Letter %c unknown type", cmd);
                return SVGPathSegmentType_UNKNOWN;
                break;
        }
    }
    
    return SVGPathSegmentType_UNKNOWN;
}

+ (instancetype)pathSegmentWithCommand:(NSString *)command andCoordinatePairSequence:(NSArray *)coordinatePairSequence
{
    SVGPathSegment * pathSegment = [[SVGPathSegment alloc] initWithType:[SVGPathSegment typeFromString:command] andCoordinatePairSequence:coordinatePairSequence];
    
    return pathSegment;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", self.segmentTypeLetter, [self.coordinatePairSequence componentsJoinedByString:@" "]];
}
@end
