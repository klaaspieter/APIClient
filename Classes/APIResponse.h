//
//  APIResponse.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 10-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^APIResponseBlock)(id value);
typedef void(^APIResponseResolver)(APIResponseBlock resolve, APIResponseBlock reject);

@interface APIResponse : NSObject

@property (nonatomic, readwrite, copy) APIResponseBlock success;
@property (nonatomic, readonly, assign) BOOL isSuccess;
@property (nonatomic, readonly, strong) id object;

@property (nonatomic, readonly, assign) BOOL isFailure;

- (id)initWithResolver:(APIResponseResolver)resolver;

@end
