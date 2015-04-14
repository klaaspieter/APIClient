//
//  APIHTTPClient.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 09/04/15.
//  Copyright (c) 2015 Klaas Pieter Annema. All rights reserved.
//

#import "APIHTTPClient.h"

@implementation APIHTTPClient

- (id)initWithBaseURL:(NSURL *)baseURL sessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration;
{
    self = [super init];
    if (self) {
        _baseURL = baseURL;
        _sessionConfiguration = sessionConfiguration;
    }
    return self;
}

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure;
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:self.sessionConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];

    NSURL *url = ({

        NSURLComponents *components = [NSURLComponents componentsWithURL:self.baseURL resolvingAgainstBaseURL:NO];
        components.path = [components.path stringByAppendingPathComponent:path];

        if (parameters.count > 0) {
            components.queryItems = ({
                NSMutableArray *queryItems = [NSMutableArray array];
                [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:obj]];
                }];
                [queryItems copy];
            });
        };

        components.URL;
    });

    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            success(data);
        } else {
            failure(error);
        }
    }] resume];
}

@end
