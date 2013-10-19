//
//  APIMappingProvider.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 19-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIMappingProvider <NSObject>
- (NSDictionary *)mappingsForResource:(Class)resource;
@end
