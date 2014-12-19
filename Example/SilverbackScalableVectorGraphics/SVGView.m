//
//  SVGView.m
//  SilverbackScalableVectorGraphics
//
//  Created by Christian Otkjær on 19/12/14.
//  Copyright (c) 2014 christian otkjær. All rights reserved.
//

#import "SVGView.h"

#import <SilverbackScalableVectorGraphics/SVGSVGElement.h>

@interface SVGView ()

@property (nonatomic, strong) SVGSVGElement * canvasElement;

@end


@implementation SVGView

- (SVGSVGElement *)canvasElement
{
    if (_canvasElement == nil)
    {
        if (_svgElement)
        {
            CGFloat width = self.svgElement.width.value;
            CGFloat height = self.svgElement.height.value;
            
            CGFloat scaleFactor = MIN((width < 1.f) ? 1.f : self.bounds.size.width / width,
                                      (height < 1.f) ? 1.f : self.bounds.size.height / height);
            
            _canvasElement = [[SVGSVGElement alloc] initWithParent:nil andAttributes:@{@"width" : @(width), @"height" : @(height), @"transform" : [NSString stringWithFormat:@"scale(%.3f)", scaleFactor]}];
            
            [_canvasElement addElement:_svgElement];

        }
    }
    
    return _canvasElement;
}

- (void)setContentMode:(UIViewContentMode)contentMode
{
    if (contentMode != self.contentMode)
    {
        _canvasElement = nil;
    }
    
    [super setContentMode:contentMode];
}

- (void)setBounds:(CGRect)bounds
{
    if (!CGRectEqualToRect(self.bounds, bounds))
    {
        _canvasElement = nil;
    }
    
    [super setBounds:bounds];
}

- (void)setSvgElement:(SVGSVGElement *)svgElement
{
    if (_svgElement != svgElement)
    {
        _svgElement = svgElement;
        
        _canvasElement = nil;
        
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    [self.canvasElement render];
}

@end
