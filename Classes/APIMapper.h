//
//  APIMapper.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 13-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIInflector.h"
#import "APIMappingProvider.h"

@protocol APIMapper <NSObject>
- (id)mapValues:(id)values toResource:(Class)resource;
- (id)mapValues:(id)values toResources:(Class)resource;
@end

@interface APIMapper : NSObject <APIMapper>
@property (nonatomic, readwrite, strong) id<APIInflector> inflector;

- (id)initWithMappingProvider:(id<APIMappingProvider>)mappingProvider;
- (id)initWithInflector:(id<APIInflector>)inflector mappingProvicer:(id<APIMappingProvider>)mappingProvider;
@end
