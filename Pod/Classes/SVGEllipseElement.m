//
//  SVGEllipseElement.m
//  Pods
//
//  Created by Christian Otkjær on 17/12/14.
//
//

#import "SVGEllipseElement.h"
#import "SVGCoordinateSystem.h"

@interface SVGEllipseElement()

//@property (nonatomic, strong) SVGCoordinate * cx;
//@property (nonatomic, strong) SVGCoordinate * cy;
//@property (nonatomic, strong) SVGLength * rx;
//@property (nonatomic, strong) SVGLength * ry;

@property (nonatomic, strong) UIBezierPath * rawBezierPath;

@end

@implementation SVGEllipseElement

- (NSString *)name
{
    return @"ellipse";
}

#pragma mark - Attributes

@synthesize cx = _cx;

- (SVGCoordinate *)cx
{
    if (_cx == nil)
    {
        _cx = [SVGCoordinate fromText:self.attributes[@"cx"]];
    }
    return _cx;
}

@synthesize cy = _cy;

- (SVGCoordinate *)cy
{
    if (_cy == nil)
    {
        _cy = [SVGCoordinate fromText:self.attributes[@"cy"]];
    }
    return _cy;
}

@synthesize rx = _rx;

- (SVGLength *)rx
{
    if (_rx == nil)
    {
        _rx = [SVGLength fromText:self.attributes[@"rx"]];
    }
    
    return _rx;
}

@synthesize ry = _ry;

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
    SVGCoordinate * absoluteCX = [self.coordinateSystem absoluteCoordinate:self.cx];
    SVGCoordinate * absoluteCY = [self.coordinateSystem absoluteCoordinate:self.cy];

    SVGLength * absoluteRX = [self.coordinateSystem absoluteLength:self.rx];
    SVGLength * absoluteRY = [self.coordinateSystem absoluteLength:self.ry];
    
    CGRect ellipseRect = CGRectMakeAtCenter(absoluteCX.value,
                                            absoluteCY.value,
                                            absoluteRX.value * 2.f,
                                            absoluteRY.value * 2.f);
    
    NSLog(@"ellipse : cx = %.3f cy = %3f - rx = %.3f, ry = %.3f", absoluteCX.value, absoluteCY.value, absoluteRX.value, absoluteRY.value);

    UIBezierPath * ellipse = [UIBezierPath bezierPathWithOvalInRect:ellipseRect];
    
    return ellipse;
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
    if (self.fillColor)
    {
        [self.fillColor.UIColor setFill];
        [self.rawBezierPath fill];
    }
    
    if (self.strokeColor)
    {
        [self.strokeColor.UIColor setStroke];
        [self.rawBezierPath stroke];
    }
    
}

@end
