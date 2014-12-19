//
//  SVGView.h
//  SilverbackScalableVectorGraphics
//
//  Created by Christian Otkjær on 19/12/14.
//  Copyright (c) 2014 christian otkjær. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVGSVGElement;

@interface SVGView : UIView

@property (nonatomic, strong) SVGSVGElement* svgElement;

@end
