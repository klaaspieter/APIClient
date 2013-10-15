//
//  APIMapper.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 13-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIMapper <NSObject>
- (BOOL)mapValuesFrom:(id)values toInstance:(id)instance usingMapping:(NSDictionary *)mapping;
@end

@interface APIMapper : NSObject <APIMapper>

@end
