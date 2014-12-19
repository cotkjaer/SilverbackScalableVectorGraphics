//
//  TestSVGDocument.m
//  
//
//  Created by Christian Otkjær on 17/12/14.
//
//

#import <SilverbackScalableVectorGraphics/SVGDocument.h>

SpecBegin(SVGDocument)

describe(@"SVGDocument", ^{
    
    NSString * fileName = @"test01";
    
    NSURL* url = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"svg"];
    
    
    SVGDocument * document = [SVGDocument svgNamed:fileName];
    
    it(@"s factory works",
       ^{
           expect(document).notTo.beNil();
       });
    
    it(@"can parse",
       ^{
           expect(document.svgElement).willNot.beNil();
       });
    
    it(@"will wait and succeed", ^AsyncBlock {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            done();
        });
    });
});

SpecEnd
