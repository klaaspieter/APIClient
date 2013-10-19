//
//  APIMapper.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 13-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIMapper <NSObject>
- (id)mapValues:(id)values toResource:(Class)resource;
@end

@interface APIMapper : NSObject <APIMapper>
@end
