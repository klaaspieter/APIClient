//
//  APIResourceNamer.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 20-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIInflector.h"

@protocol APIResourceNamer <NSObject>

- (NSString *)nameForResource:(Class)resource;
- (NSString *)pluralizedNameForResource:(Class)resource;

@end

@interface APIResourceNamer : NSObject <APIResourceNamer>

@property (nonatomic, readwrite, strong) APIInflector *inflector;

- (id)initWithInflector:(APIInflector *)inflector;

@end
