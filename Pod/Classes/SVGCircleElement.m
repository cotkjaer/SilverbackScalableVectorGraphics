//
//  SVGCircleElement.m
//  Pods
//
//  Created by Christian Otkjær on 18/12/14.
//
//

#import "SVGCircleElement.h"
#import "SVGRenderingContext.h"
#import "SVGCoordinate.h"

@interface SVGCircleElement ()

@property (nonatomic, strong) SVGCoordinate * cx;
@property (nonatomic, strong) SVGCoordinate * cy;
@property (nonatomic, strong) SVGLength * r;

@property (nonatomic, strong) UIBezierPath * rawBezierPath;

@end

@implementation SVGCircleElement

- (NSString *)name
{
    return @"circle";
}

#pragma mark - Attributes

- (SVGCoordinate *)cx
{
    if (_cx == nil)
    {
        _cx = [SVGCoordinate fromText:self.attributes[@"cx"]];
    }
    return _cx;
}

- (SVGCoordinate *)cy
{
    if (_cy == nil)
    {
        _cy = [SVGCoordinate fromText:self.attributes[@"cy"]];
    }
    return _cy;
}

- (SVGLength *)r
{
    if (_r == nil)
    {
        _r = [SVGLength fromText:self.attributes[@"r"]];
    }
    
    return _r;
}

#pragma mark - Rendering

- (UIBezierPath *)createRawBezierPath
{
    CGFloat sideLength = self.r.value * 2.f;
    
    return [UIBezierPath bezierPathWithOvalInRect:CGRectMakeAtCenter(self.cx.value,
                                                                     self.cy.value,
                                                                     sideLength,
                                                                     sideLength)];
}

- (UIBezierPath *)rawBezierPath
{
    if (_rawBezierPath == nil)
    {
        _rawBezierPath = [self createRawBezierPath];
    }
    
    return _rawBezierPath;
}

- (void)renderInContext:(SVGRenderingContext *)context
{
    [self.rawBezierPath stroke];
}

#pragma mark - Description

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@, cx = %@, cy = %@, r = %@\n%@", self.name, self.cx, self.cy, self.r, [super description]];
}
@end
