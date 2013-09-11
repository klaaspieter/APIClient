//
//  APIResponse.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 10-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIResponse.h"

@interface APIResponse ()
@property (nonatomic, readwrite, assign) BOOL isSuccess;
@property (nonatomic, readwrite, strong) id object;

@property (nonatomic, readwrite, assign) BOOL isFailure;
@end

@implementation APIResponse

- (id)initWithResolver:(APIResponseResolver)resolver;
{
    if (self = [super init])
    {
        resolver(^(id object){
            self.isSuccess = YES;
            self.object = object;
        }, ^(id error){
            self.isFailure = YES;
        });
    }

    return self;
}

@end
