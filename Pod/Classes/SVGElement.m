//
//  SVGElement.m
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGElement.h"

#import "SVGSVGElement.h"
#import "SVGPathElement.h"
#import "SVGGroupElement.h"
#import "SVGEllipseElement.h"
#import "SVGCircleElement.h"
#import "SVGPolygonElement.h"
#import "SVGPolylineElement.h"
#import "SVGlineElement.h"
#import "SVGTextElement.h"

inline CGRect CGRectMakeAtCenter(CGFloat cx, CGFloat cy, CGFloat width, CGFloat height)
{
    return CGRectMake(cx - width/2.f, cy-height/2.f, width, height);
}

inline CGRect CGRectMakeSquare(CGFloat ox, CGFloat oy, CGFloat side)
{
    return CGRectMake(ox, oy, side, side);
}


@implementation SVGElement

+ (SVGElement *)svgElementForElementName:(NSString *)elementName
                                  parent:(SVGContainerElement *)parent
                              attributes:(NSDictionary *)attributes
{
    NSDictionary * nameToClass =
    @{@"svg" : [SVGSVGElement class],
      @"path" : [SVGPathElement class],
      @"ellipse" : [SVGEllipseElement class],
      @"circle" : [SVGCircleElement class],
      @"polygon" : [SVGPolygonElement class],
      @"polyline" : [SVGPolylineElement class],
      @"line" : [SVGLineElement class],
      @"text" : [SVGTextElement class],
      @"g" : [SVGGroupElement class]};

    if (nameToClass[elementName] != nil)
    {
        Class type = nameToClass[elementName];
        
        return [[type alloc] initWithParent:parent andAttributes:attributes];
    }
    else
    {
        return nil;
    }
}

- (instancetype)initWithParent:(id)parentElement
                 andAttributes:(NSDictionary *)attributes
{
    self = [super init];
    
    if (self)
    {
        _parent = parentElement;
        _attributes = attributes;
    }
    
    return self;
}

#pragma mark - Coordinate System

- (SVGCoordinateSystem *)coordinateSystem
{
    return self.parent.coordinateSystem;
}

#pragma mark - Rendering

- (void)render
{
    NSLog(@"WARNING: Executing %@.%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

#pragma mark - Description

- (NSString *)description
{
    NSMutableArray * attributesDescriptions = [NSMutableArray new];
    
    [self.attributes enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        [attributesDescriptions addObject:[NSString stringWithFormat:@"%@='%@'", key, obj]];
    }];
    
    return [NSString stringWithFormat:@"<%@ %@ />", self.name, [attributesDescriptions componentsJoinedByString:@" "]];
}

@end
