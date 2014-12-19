//
//  TestSVGParser.m
//  SilverbackScalableVectorGraphics
//
//  Created by Christian Otkjær on 16/12/14.
//  Copyright (c) 2014 christian otkjær. All rights reserved.
//

#import <SilverbackScalableVectorGraphics/SVGParser.h>
#import <SilverbackScalableVectorGraphics/SVGSVGElement.h>
#import <SilverbackScalableVectorGraphics/SVGPathElement.h>

@interface MockSVGParserDelegate : NSObject <SVGParserDelegate>

@property (nonatomic) NSUInteger didFinishCallCount;
@property (nonatomic) NSUInteger didBeginCallCount;
@property (nonatomic) NSUInteger didProduceElementCallCount;

@end

@implementation MockSVGParserDelegate

- (void)parserDidFinishParsing:(SVGParser *)parser
{
    self.didFinishCallCount++;
}

- (void)parserDidBeginParsing:(SVGParser *)parser
{
    self.didBeginCallCount++;
}

- (void)parser:(SVGParser *)parser didProduceTopLevelElement:(SVGElement *)element
{
    self.didProduceElementCallCount++;
}

@end

SpecBegin(SVGParser)

NSString* testString1 = @"<svg height='300' width='400'><path d='M150 0 L75 200 L225 200 Z' /></svg>";

NSString* testString2 = @"<path d='M150 0 L75 200 L225 200 Z' />";

describe(@"SVGParser can parse", ^{
    
    it(@"svg element", ^{
        
        SVGParser * parser = [SVGParser new];
        
        [parser parseXmlString:testString1];
        
        expect(parser.topLevelSvgElements.count).equal(1);
        
        expect([parser.topLevelSvgElements firstObject]).beInstanceOf([SVGSVGElement class]);
    });
    
    it(@"path element", ^{
        
        SVGParser * parser = [SVGParser new];
        
        [parser parseXmlString:testString2];
        
        expect(parser.topLevelSvgElements.count).equal(1);
        
        expect([parser.topLevelSvgElements firstObject]).beInstanceOf([SVGPathElement class]);
    });
    
});

describe(@"SVGParser", ^{
    
    __block SVGParser * parser;
    
    __block MockSVGParserDelegate * delegate;;
    
    parser.delegate = delegate;
    
    beforeAll(^{
        // All asynchronous matching using `will` and `willNot`
        // will have a timeout of 2.0 seconds
        [Expecta setAsynchronousTestTimeout:2];
    });
    
    beforeEach(^{
        parser = [SVGParser new];
        
        delegate = [MockSVGParserDelegate new];
        
        parser.delegate = delegate;
    });
    
    it(@"did call delegate", ^{
        
        [parser parseXmlString:testString2];

        expect(delegate.didBeginCallCount).will.equal(1);
        expect(delegate.didFinishCallCount).will.equal(1);
        expect(delegate.didProduceElementCallCount).will.equal(1);
    });
});

SpecEnd