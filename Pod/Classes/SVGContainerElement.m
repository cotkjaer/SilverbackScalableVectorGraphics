//
//  SVGContainerElement.m
//  Pods
//
//  Created by Christian Otkjær on 17/12/14.
//
//

#import "SVGContainerElement.h"
#import "SVGCoordinateSystem.h"

@interface SVGContainerElement ()


@property (nonatomic, strong) NSMutableArray * childElements;
@property (nonatomic, strong) NSMutableArray * texts;

@end

@implementation SVGContainerElement

- (instancetype)initWithParent:(SVGContainerElement *)parentElement
                 andAttributes:(NSDictionary *)attributes
{
    self = [super initWithParent:parentElement andAttributes:attributes];
    
    if (self)
    {
        _childElements = [NSMutableArray new];
        _texts = [NSMutableArray new];
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithParent:nil andAttributes:nil];
}

#pragma mark - Coordinate System

- (SVGCoordinateSystem *)coordinateSystem
{
    SVGCoordinateSystem * coordinateSystem = [super coordinateSystem];
    
    if (coordinateSystem == nil)
    {
        coordinateSystem = [SVGCoordinateSystem new];
    }
    
    if([self.attributes.allKeys containsObject:@"transform"])
    {
        NSLog(@"TODO: create transformed coordinate system in %@.%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        coordinateSystem = coordinateSystem;
    }

    return coordinateSystem;
}

#pragma mark - Elements

- (void)addElement:(SVGElement *)element
{
    if ([element isKindOfClass:[SVGElement class]])
    {
        [self.childElements addObject:element];
    }
}
- (void)addText:(NSString *)text
{
    if ([text isKindOfClass:[NSString class]])
    {
        [self.texts addObject:text];
    }
}

#pragma mark - description

- (NSString *)description
{
    NSMutableArray * attributesDescriptions = [NSMutableArray new];
    
    [self.attributes enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
     {
         [attributesDescriptions addObject:[NSString stringWithFormat:@"%@='%@'", key, obj]];
     }];
    
    NSMutableArray * childrenDescriptions = [NSMutableArray new];
    
    [self.childElements enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        [childrenDescriptions addObject:[obj description]];
    }];
    
    return [NSString stringWithFormat:@"<%@ %@>\n%@\%@\n</%@>", self.name, [attributesDescriptions componentsJoinedByString:@" "], [childrenDescriptions componentsJoinedByString:@"\n"],[self.texts componentsJoinedByString:@"\n"], self.name];
}

@end
