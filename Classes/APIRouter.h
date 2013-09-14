//
//  APIRouter.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIInflector.h"

@protocol APIRouter <NSObject>
@property (nonatomic, readonly, strong) id<APIInflector> inflector;

- (NSString *)pathForAction:(NSString *)action onResource:(Class)resource;
@end

@interface APIRouter : NSObject <APIRouter>
- (id)initWithInflector:(id<APIInflector>)inflector;
- (NSString *)pathForAction:(NSString *)action onResource:(Class)resource;
@end
