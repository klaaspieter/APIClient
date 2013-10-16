//
//  APIMappingProvider.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 15-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIMappingProvider <NSObject>
- (NSDictionary *)mappingForResource:(Class)resource;
@end
