//
//  SVGSVGElement.m
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGSVGElement.h"
#import "SVGTransformation.h"

@implementation SVGSVGElement

#pragma mark - Attributes

@synthesize x = _x;

- (SVGCoordinate *)x
{
    if (_x == nil)
    {
        _x = [SVGCoordinate fromText:self.attributes[@"x"]];
    }
    return _x;
}

@synthesize y = _y;

- (SVGCoordinate *)y
{
    if (_y == nil)
    {
        _y = [SVGCoordinate fromText:self.attributes[@"y"]];
    }
    return _y;
}

@synthesize width = _width;

- (SVGLength *)width
{
    if (_width == nil)
    {
        _width = [SVGLength fromText:self.attributes[@"width"]];
    }
    
    return _width;
}

@synthesize height = _height;

- (SVGLength *)height
{
    if (_height == nil)
    {
        _height = [SVGLength fromText:self.attributes[@"height"]];
    }
    
    return _height;
}

#pragma mark - Name

- (NSString *)name
{
    return @"svg";
}


@end
