//
//  HTTPClient.m
//  Example
//
//  Created by Klaas Pieter Annema on 22-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient

- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;
{
    path = [path stringByAppendingString:@"?key=0cddf7ec249232832da492429491d3f4"];
    [super getPath:path parameters:parameters success:success failure:failure];
}

@end
