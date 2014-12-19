//
//  TestSVGDocumentSource.m
//  SilverbackScalableVectorGraphics
//
//  Created by Christian Otkjær on 17/12/14.
//  Copyright (c) 2014 christian otkjær. All rights reserved.
//

#import <SilverbackScalableVectorGraphics/SVGDocumentSource.h>

NSString* svgText = @"<svg height='300' width='400'><path d='M150 0 L75 200 L225 200 Z' /></svg>";


SpecBegin(SVGDocumentSource)

describe(@"init", ^{
        
    it(@"initWithText:", ^
    {
        SVGDocumentSource * documentSource = [[SVGDocumentSource alloc]
                                              initWithText:svgText];
        expect(documentSource.stream).notTo.beNil;
    });

    it(@"initWithData:", ^
       {
           NSData * data = [svgText dataUsingEncoding:NSUTF8StringEncoding];

           SVGDocumentSource * documentSource = [[SVGDocumentSource alloc]
                                                 initWithData:data];
           
           expect(documentSource.stream).notTo.beNil;
       });

    
    it(@"initWithFileNamed:", ^
    {
        SVGDocumentSource * documentSource = [[SVGDocumentSource alloc]
                                              initWithFileNamed:@"test01"];
        
        expect(documentSource.stream).notTo.beNil;
    });
});

SpecEnd