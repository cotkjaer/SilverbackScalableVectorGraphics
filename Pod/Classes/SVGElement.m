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

#import "SVGStyleParser.h"

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

#pragma mark - Attributes

@synthesize attributes = _attributes;

- (NSDictionary *)attributes
{
    if ([_attributes.allKeys containsObject:@"style"])
    {
        NSMutableDictionary * attributes = [_attributes mutableCopy];
        
        NSString * styleText = attributes[@"style"];
        
        NSDictionary * styleAttributes = [SVGStyleParser attributesFromStyleText:styleText];
        
        [styleAttributes enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSString * value, BOOL *stop)
        {
            if (key.length > 0)
            {
                if (attributes[key] && ![value isEqualToString:attributes[key]])
                {
                    NSLog(@"Ignoring style attribute %@ with value %@, real attribute with value %@ already set", key, value, attributes[key]);
                }
                else
                {
                    attributes[key] = value;
                }
            }
        }];
        
        [attributes removeObjectForKey:@"style"];
        
        _attributes = [attributes copy];
    }
    
    return _attributes;
}

#pragma mark - Rendering

@synthesize strokeColor = _strokeColor;

- (SVGColor *)strokeColor
{
    if (_strokeColor == nil)
    {
        _strokeColor = [self.parent strokeColor];
        
        if (self.attributes[@"stroke"])
        {
            _strokeColor = [SVGColor colorFromText:self.attributes[@"stroke"]];
        }
    }
    
    return _strokeColor;
}


@synthesize fillColor = _fillColor;

- (SVGColor *)fillColor
{
    if (_fillColor == nil)
    {
        _fillColor = [self.parent fillColor];
        
        if (self.attributes[@"fill"])
        {
            _fillColor = [SVGColor colorFromText:self.attributes[@"fill"]];
        }
    }
    
    return _fillColor;
}

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
