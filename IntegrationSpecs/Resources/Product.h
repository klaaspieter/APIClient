//
//  Product.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 08-12-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, assign) NSUInteger price;
@property (nonatomic, readonly, assign) BOOL inStock;
@property (nonatomic, readonly, assign) double balanceIncrease;

@end
