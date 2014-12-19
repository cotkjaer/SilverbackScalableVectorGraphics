//
//  SVGViewController.m
//  SilverbackScalableVectorGraphics
//
//  Created by christian otkjær on 12/16/2014.
//  Copyright (c) 2014 christian otkjær. All rights reserved.
//

#import "SVGViewController.h"

#import "SVGDocument.h"
#import "SVGSVGElement.h"
#import "SVGView.h"

@interface SVGViewController ()

@property (nonatomic, strong) SVGDocument * svg;

@end

NSString* testString = @"<svg height='210' width='400'><path d='M150 0 L75 200 L225 200 Z' /></svg>";

@implementation SVGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    
    self.pathField.text = @"test01";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)parseButtonPressed:(id)sender
{
    NSURL * url = [[NSBundle mainBundle] URLForResource:self.pathField.text withExtension:@"svg"];

    if (url)
    {
        self.svg = [SVGDocument svgNamed:self.pathField.text];
        self.parsedLabel.text = [self.svg description];
    }
    else
    {
        self.parsedLabel.text = @"No such SVG";
    }
}

- (void)updateLabel
{
    if (self.svg)
    {
        if (self.svg.svgElement)
        {
            self.parsedLabel.text = [self.svg.svgElement description];
            self.svgView.svgElement = self.svg.svgElement;
        }
        else if (self.svg.error)
        {
            self.parsedLabel.text = self.svg.error.localizedDescription;
        }
        else
        {
            self.parsedLabel.text = [self.svg description];
        }
    }
    else
    {
        self.parsedLabel.text = @"No SVG";
    }
}


@end
