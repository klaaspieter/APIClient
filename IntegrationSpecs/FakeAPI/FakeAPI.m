//
//  FakeAPI.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 06-12-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "FakeAPI.h"

#import "Barista.h"
#import "BARStaticFileServer.h"

@interface FakeAPI ()
@property (nonatomic, readwrite, strong) BARServer *server;
@end

@implementation FakeAPI

- (void)start;
{
    [self.server startListening];
}

- (void)stop;
{
    [self.server stopListening];
}

- (BARServer *)server;
{
    if (!_server)
    {
        _server = [BARServer serverWithPort:3333];
        NSURL *directoryURL = [[[NSBundle bundleForClass:self.class] bundleURL] URLByAppendingPathComponent:@"Responses"];
        [_server addGlobalMiddleware:[BARStaticFileServer fileServerWithDirectoryURL:directoryURL forURLBasePath:@"/"]];
    }

    return _server;
}

@end
