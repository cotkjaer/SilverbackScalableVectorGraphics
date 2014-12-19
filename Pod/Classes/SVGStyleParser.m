//
//  SVGStyleParser.m
//  Pods
//
//  Created by Christian Otkjær on 19/12/14.
//
//

#import "SVGStyleParser.h"

@implementation SVGStyleParser

+ (BOOL)updateAttributes:(NSMutableDictionary *)attributes
                  forKey:(NSString *)key
               withValue:(NSString *)value
{
    if (key.length > 0)
    {
        if (attributes[key])
        {
            NSLog(@"Overriding %@ with %@, (was %@)", key, value, attributes[key]);
        }
        
        attributes[key] = value;
        
        return YES;
    }
    
    return NO;
}

+ (NSDictionary *)attributesFromStyleText:(NSString *)styleText
{
    NSMutableDictionary * attributes = [NSMutableDictionary new];
    
    NSArray * blocks = [styleText componentsSeparatedByString:@";"];
    
    [blocks enumerateObjectsUsingBlock:^(NSString * block, NSUInteger idx, BOOL *stop)
    {
        NSArray * keyAndValue = [block componentsSeparatedByString:@":"];
        
        switch (keyAndValue.count)
        {
            case 0:
            case 1:
                NSLog(@"Cannot parse %@", block);
                break;
                
            case 2:
            {
                NSString * key = [keyAndValue firstObject];
                NSString * value = [keyAndValue lastObject];
                
                if (![self updateAttributes:attributes forKey:key withValue:value])
                {
                    NSLog(@"Cannot parse %@", block);
                }
            }
                break;
                
            default:
            {
                NSString * key = [keyAndValue firstObject];
                NSString * value = [[keyAndValue subarrayWithRange:NSMakeRange(1, keyAndValue.count -1)] componentsJoinedByString:@":"];
                
                if (![self updateAttributes:attributes forKey:key withValue:value])
                {
                    NSLog(@"Cannot parse %@", block);
                }
            }
                break;
        }
    }];
    
    return [attributes copy];
}

@end

