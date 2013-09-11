//
//  APIResponse.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 10-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIResponse.h"

@interface APIResponse ()
@property (nonatomic, readwrite, assign) BOOL isFinished;

@property (nonatomic, readwrite, assign) BOOL isSuccess;
@property (nonatomic, readwrite, strong) id object;

@property (nonatomic, readwrite, assign) BOOL isFailure;
@property (nonatomic, readwrite, strong) id error;
@end

@implementation APIResponse

- (id)initWithResolver:(APIResponseResolver)resolver;
{
    if (self = [super init])
    {
        resolver(^(id object){
            [self resolveWithObject:object];
        }, ^(id error){
            [self rejectWithError:error];
        });
    }

    return self;
}

- (BOOL)isFinished;
{
    return self.isSuccess || self.isFailure;
}

#pragma - Resolving
- (void)resolveWithObject:(id)object;
{
    NSAssert(!self.isFinished, @"A finished response cannot be resolved");
    
    self.isSuccess = YES;
    self.object = object;
    [self performResolve];
}

- (void)performResolve;
{
    if (!self.isSuccess)
        return;

    if (self.success)
        self.success(self.object);
}

- (void)setSuccess:(APIResponseBlock)success;
{
    if (_success == success)
        return;

    _success = success;
    [self performResolve];
}

#pragma - Rejecting
- (void)rejectWithError:(id)error;
{
    NSAssert(!self.isFinished, @"A finished response cannot be rejected");
    
    self.isFailure = YES;
    self.error = error;
    [self performReject];
}

- (void)performReject;
{
    if (!self.isFailure)
        return;

    if (self.failure)
        self.failure(self.error);
}

@end
