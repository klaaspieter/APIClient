//
//  FakeAPI.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 06-12-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeAPI : NSObject

- (id)initWithPort:(NSUInteger)port;

- (void)start;
- (void)stop;

@end
