//
//  SVGEllipseElement.m
//  Pods
//
//  Created by Christian Otkjær on 17/12/14.
//
//

#import "SVGEllipseElement.h"

@interface SVGEllipseElement()

@property (nonatomic, strong) SVGCoordinate * cx;
@property (nonatomic, strong) SVGCoordinate * cy;
@property (nonatomic, strong) SVGLength * rx;
@property (nonatomic, strong) SVGLength * ry;

@property (nonatomic, strong) UIBezierPath * rawBezierPath;

@end

@implementation SVGEllipseElement

- (NSString *)name
{
    return @"ellipse";
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

- (SVGLength *)rx
{
    if (_rx == nil)
    {
        _rx = [SVGLength fromText:self.attributes[@"rx"]];
    }
    
    return _rx;
}

- (SVGLength *)ry
{
    if (_ry == nil)
    {
        _ry = [SVGLength fromText:self.attributes[@"ry"]];
    }
    
    return _ry;
}

#pragma mark - Rendering

- (UIBezierPath *)createRawBezierPath
{
    return [UIBezierPath bezierPathWithOvalInRect:CGRectMakeAtCenter(self.cx.value,
                                                                     self.cy.value,
                                                                     self.rx.value * 2.f,
                                                                     self.ry.value * 2.f)];
}

- (UIBezierPath *)rawBezierPath
{
    if (_rawBezierPath == nil)
    {
        _rawBezierPath = [self createRawBezierPath];
    }
    
    return _rawBezierPath;
}

- (void)render
{
    [self.rawBezierPath stroke];
}

@end
