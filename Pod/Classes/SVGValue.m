//
//  SVGValue.m
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGValue.h"

@interface SVGValue ()

@property (nonatomic, readonly, strong) NSNumber * numberValue;

@end

@implementation SVGValue

inline SVGFloat SVGFloatFromString(NSString * str)
{
    return [str floatValue];
}

inline SVGCoordinatePair SVGCoordinatePairMake(SVGFloat x, SVGFloat y)
{
    SVGCoordinatePair p; p.x = x; p.y = y; return p;
}


+ (NSNumberFormatter *)numberFormatter
{
    static NSNumberFormatter * singleton = nil;
    
    static dispatch_once_t _once_token;
    
    dispatch_once(&_once_token, ^
                  {
                      singleton = [NSNumberFormatter new];
                      singleton.numberStyle = NSNumberFormatterDecimalStyle;
                  });
    
    return singleton;
}

+ (NSCache *)valueCache
{
    static NSCache * singleton = nil;
    
    static dispatch_once_t _once_token;
    
    dispatch_once(&_once_token, ^
                  {
                      singleton = [NSCache new];
                  });
    
    return singleton;
}


- (float)value
{
    return [self.numberValue floatValue];
}


#pragma mark - Factory

- (instancetype)initWithValue:(SVGFloat)value
{
    return [self initWithNumberValue:@(value)];
}

- (instancetype)initWithNumberValue:(NSNumber *) value
{
    self = [super init];
    
    if (self)
    {
        _numberValue = value;
    }
    
    return self;
}



+ (NSScanner *)numberScanner
{
    static NSScanner * singleton = nil;
    
    static dispatch_once_t _once_token;
    
    dispatch_once(&_once_token, ^
                  {
                      singleton = [NSScanner new];
                  });
    
    return singleton;
}

+ (NSNumber *)scanNumberFromText:(NSString *)valueText
{
    float number;
    
    [[NSScanner scannerWithString:valueText] scanFloat:&number];
    
    return @(number);
}

+ (instancetype)fromText:(NSString *)valueText
{
    NSNumber * numberValue = [self scanNumberFromText:valueText]; //[[SVGValue numberFormatter] numberFromString:valueText];
    
    if (numberValue == nil)
    {
        numberValue = @0;
    }
    
    id value = [[self valueCache] objectForKey:numberValue];
    
    if (value == nil)
    {
        value = [[self alloc] initWithNumberValue:numberValue];
        [[self valueCache] setObject:value forKey:numberValue];
    }
    
    return value;
}

#pragma mark - description

- (NSString *)description
{
    return [self.numberValue stringValue];
}

@end
