//
//  Product.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 10-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readwrite, assign) NSUInteger price;
@property (nonatomic, readwrite, assign) double balanceIncrease;
@property (nonatomic, readwrite, assign) BOOL inStock;
@end
