//
//  FileServerMiddleware.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 09-12-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "BARStaticFileServer.h"

@interface FileServerMiddleware : NSObject <BaristaMiddleware>

+ (instancetype)fileServerMiddleWithDirectoryURL:(NSURL *)directoryURL forURLBasePath:(NSString *)basePath;
- (id)initWithDirectoryURL:(NSURL *)directoryURL forURLBasePath:(NSString *)basePath;

@end
