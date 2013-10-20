//
//  APIMapper.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 13-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIResourceNamer.h"
#import "APIMappingProvider.h"

@protocol APIMapper <NSObject>
- (NSArray *)mapValues:(id)values toResource:(Class)resource;
@end

@interface APIMapper : NSObject <APIMapper>
@property (nonatomic, readwrite, strong) id<APIResourceNamer> resourceNamer;
@property (nonatomic, readwrite, strong) id<APIMappingProvider> mappingProvider;

- (id)initWithMappingProvider:(id<APIMappingProvider>)mappingProvider;
- (id)initWithResourceNamer:(id<APIResourceNamer>)resourceNamer mappingProvider:(id<APIMappingProvider>)mappingProvider;

- (NSString *)rootForResource:(Class)resource;
@end
