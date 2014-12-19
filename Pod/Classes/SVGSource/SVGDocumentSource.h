//
//  SVGLocalFileSource.h
//  Pods
//
//  Created by Christian Otkjær on 17/12/14.
//
//

@import Foundation;

@interface SVGDocumentSource : NSObject

@property (nonatomic, readonly) NSInputStream* stream;

/// no .svg in fileName
- (instancetype)initWithFileNamed:(NSString *)fileName;

- (instancetype)initWithData:(NSData *)data;

- (instancetype)initWithText:(NSString *)text;

/// .svg in fileURL
- (instancetype)initWithUrl:(NSURL *)fileURL;

- (instancetype)initWithStream:(NSInputStream *)stream;

@end
