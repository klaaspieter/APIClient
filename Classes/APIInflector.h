//
//  APIInflector.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIInflector <NSObject>
- (NSString *)pluralize:(NSString *)string;
@end

@interface APIInflector : NSObject <APIInflector>
- (NSString *)pluralize:(NSString *)string;
@end
