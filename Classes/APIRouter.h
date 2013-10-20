//
//  APIRouter.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIResourceNamer.h"

@protocol APIRouter <NSObject>
- (NSString *)pathForAction:(NSString *)action onResource:(Class)resource;
- (NSString *)pathForAction:(NSString *)action onResource:(Class)resource withArguments:(NSDictionary *)arguments;
@end

@interface APIRouter : NSObject <APIRouter>
@property (nonatomic, readwrite, strong) id<APIResourceNamer> resourceNamer;

- (id)initWithResourceNamer:(id<APIResourceNamer>)resourceNamer;
@end
