//
// APIResponse.m
//
// Copyright (c) 2015 Klaas Pieter Annema (http://annema.me)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
