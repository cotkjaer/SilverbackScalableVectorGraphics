//
//  SVGPathElement.m
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGPathElement.h"

#import "SVGValue.h"

#import "SVGPathSegmentMoveTo.h"

#import "SVGPathAndPointParser.h"

@interface SVGPathElement ()

@property (nonatomic, strong) NSArray * pathSegments;

@end

@implementation SVGPathElement

- (instancetype)initWithPathSegments:(NSArray *)pathSegments
{
    self = [super init];
    
    if (self)
    {
        _pathSegments = [pathSegments copy];
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithPathSegments:nil];
}

- (NSString *)name
{
    return @"path";
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    SVGMutablePathElement * mutableCopy = [SVGMutablePathElement new];
    
    mutableCopy.pathSegments = [self.pathSegments mutableCopy];
    
    return mutableCopy;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[SVGPathElement alloc] initWithPathSegments:self.pathSegments];
}

@end

@interface SVGMutablePathElement ()

@property (nonatomic, strong) NSMutableArray * mutablePathSegments;

@end

@implementation SVGMutablePathElement

- (instancetype)initWithParent:(SVGContainerElement *)parentElement andAttributes:(NSDictionary *)attributes
{
    self = [super initWithParent:parentElement andAttributes:attributes];
    
    if (self)
    {
        _mutablePathSegments = [NSMutableArray new]; // Lazy
    }
    
    return self;
}

- (NSMutableArray *)mutablePathSegments
{
    if (_mutablePathSegments == nil)
    {
        _mutablePathSegments = [NSMutableArray new];
        [self addPathSegmentsFromSegmentsString:self.attributes[@"d"]];
    }
    return _mutablePathSegments;
}

- (void)addPathSegment:(SVGPathSegment *)pathSegment
{
    [self.mutablePathSegments addObject:pathSegment];
}

- (NSArray *)pathSegments
{
    return [self.mutablePathSegments copy];
}

- (NSArray *)parseSegmentsString:(NSString *)segmentsString;
{
    if (segmentsString.length == 0)
    {
        return nil;
    }
    
    SVGPathAndPointParser * parser = [SVGPathAndPointParser new];
    
    NSMutableArray * segmentTokens = [NSMutableArray new];
    
    NSRange searchedRange = NSMakeRange(0, [segmentsString length]);
    
    NSString * pattern = @"([a-zA-Z])|([-+]?(?:[0-9]*\\.[0-9]+|[0-9]+))";
    
    NSError * error = nil;
    
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    NSArray* matches = [regex matchesInString:segmentsString options:0 range: searchedRange];
    
    for (NSTextCheckingResult* match in matches)
    {
        NSString* matchText = [segmentsString substringWithRange:[match range]];
        NSLog(@"match: %@", matchText);
        
        [segmentTokens addObject:matchText];
        //        NSRange group1 = [match rangeAtIndex:1];
        //        NSLog(@"group1: %@", [segmentsString substringWithRange:group1]);
    }
    
    return [segmentTokens copy];
}

- (void)addPathSegmentsFromSegmentsString:(NSString *)segmentsString;
{
    NSMutableArray *segmentTokens = [[self parseSegmentsString:segmentsString] mutableCopy];
    
    while (segmentTokens.count > 0)
    {
        NSString * letter = [segmentTokens firstObject];
        [segmentTokens removeObjectAtIndex:0];
        
        if ([letter isEqualToString:@"M"] || [letter isEqualToString:@"m"])
        {
            NSString * xText = [segmentTokens firstObject];
            [segmentTokens removeObjectAtIndex:0];
            NSString * yText = [segmentTokens firstObject];
            [segmentTokens removeObjectAtIndex:0];
            
            [self addPathSegment:[[SVGPathSegmentMoveTo alloc] initWithPointType:SVGPathSegmentPointTypeAbsolute point:SVGCoordinatePairMake(SVGFloatFromString(xText), SVGFloatFromString(yText))]];
        }
        else if ([letter isEqualToString:@"m"])
        {
            NSString * xText = [segmentTokens firstObject];
            [segmentTokens removeObjectAtIndex:0];
            NSString * yText = [segmentTokens firstObject];
            [segmentTokens removeObjectAtIndex:0];
            
            [self addPathSegment:[[SVGPathSegmentMoveTo alloc] initWithPointType:SVGPathSegmentPointTypeRelative point:SVGCoordinatePairMake(SVGFloatFromString(xText), SVGFloatFromString(yText))]];
        }
    }
}

@end