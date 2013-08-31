//
//  APIClient.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIClient : NSObject

@property (nonatomic, readonly, strong) NSURL *baseURL;

+ (instancetype)clientWithBaseURL:(NSURL *)baseURL;
- (id)initWithBaseURL:(NSURL *)baseURL;

@end
