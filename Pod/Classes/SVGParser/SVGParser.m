//
//  SVGParser.m
//  Pods
//
//  Created by Christian Otkjær on 16/12/14.
//
//

#import "SVGParser.h"
#import "SVGContainerElement.h"
#import "SVGDocumentSource.h"

@interface SVGParser () <NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser * xmlParser;

@property (nonatomic, strong) NSMutableArray * topElements;

@property (nonatomic, strong) NSMutableArray * elementStack;

@property (nonatomic) BOOL didAbortParsing;

@property (nonatomic, readonly) SVGContainerElement * currentContainerElement;

@end

@implementation SVGParser

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _xmlParser = nil;
        _elementStack = [NSMutableArray new];
        _topElements = [NSMutableArray new];
    }
    
    return self;
}

- (SVGContainerElement *)currentContainerElement
{
    __block SVGContainerElement * containerElement = nil;
    
    [self.elementStack enumerateObjectsWithOptions:NSEnumerationReverse
                                        usingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         if ([obj isKindOfClass:[SVGContainerElement class]])
         {
             containerElement = obj;
             *stop = YES;
         }
     }];
    
    return containerElement;
}

- (void)parseDocumentSource:(SVGDocumentSource *)documentSource
{
    [self parseXmlStream:documentSource.stream];
}

- (void)parseXmlStream:(NSInputStream *)xmlStream
{
    self.xmlParser = [[NSXMLParser alloc] initWithStream:xmlStream];
    self.xmlParser.delegate = self;
    
    [self.elementStack removeAllObjects];
    
    [self.xmlParser parse];
}

- (void)parseXmlString:(NSString *)xmlString
{
    self.xmlParser = [[NSXMLParser alloc] initWithData:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    self.xmlParser.delegate = self;
    
    [self.elementStack removeAllObjects];
    
    [self.xmlParser parse];
}

#pragma mark - <NSXMLParserDelegate>

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    if ([self.delegate respondsToSelector:@selector(parserDidBeginParsing:)])
    {
        [self.delegate parserDidBeginParsing:self];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if ([self.delegate respondsToSelector:@selector(parserDidFinishParsing:)])
    {
        [self.delegate parserDidFinishParsing:self];
    }
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    SVGElement * element = [SVGElement svgElementForElementName:elementName parent:self.currentContainerElement attributes:attributeDict];
    
    if (element)
    {
        [self.currentContainerElement addElement:element];
        
        [self.elementStack addObject:element];
    }
    else
    {
        self.didAbortParsing = YES;
        [self.xmlParser abortParsing];
        
        if ([self.delegate respondsToSelector:@selector(parser:parseErrorOccurred:)]) {
            [self.delegate parser:self parseErrorOccurred:[NSError errorWithDomain:@"SVGParser" code:1 userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Unable to make SVG element for tag %@", elementName]}]];
        }
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    id elementFromStack = [self.elementStack lastObject];
    [self.elementStack removeLastObject];
    
    // Assume that the XML parser handles unballanced XML
    
    if (self.elementStack.count == 0)
    {
        [self.topElements addObject:elementFromStack];
        
        if ([self.delegate respondsToSelector:@selector(parser:didProduceTopLevelElement:)])
        {
            [self.delegate parser:self didProduceTopLevelElement:elementFromStack];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSString * realString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (realString.length > 0)
    {
        [self.currentContainerElement addText:realString];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    if ([parseError code] != NSXMLParserDelegateAbortedParseError && !self.didAbortParsing)
    {
        if ([self.delegate respondsToSelector:@selector(parser:parseErrorOccurred:)])
        {
            [self.delegate parser:self parseErrorOccurred:parseError];
        }
    }
}

- (NSArray *)topLevelSvgElements
{
    return [self.topElements copy];
}

@end
