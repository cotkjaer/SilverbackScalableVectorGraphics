//
//  SVGViewController.h
//  SilverbackScalableVectorGraphics
//
//  Created by christian otkjær on 12/16/2014.
//  Copyright (c) 2014 christian otkjær. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVGView;

@interface SVGViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *pathField;
@property (strong, nonatomic) IBOutlet UILabel *parsedLabel;
@property (strong, nonatomic) IBOutlet SVGView *svgView;

@end
