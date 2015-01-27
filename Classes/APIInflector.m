//
//  APIInflector.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIInflector.h"

#import <InflectorKit/TTTStringInflector.h>

@implementation APIInflector

- (NSString *)pluralize:(NSString *)string;
{
    return [[TTTStringInflector defaultInflector] pluralize:string];
}

- (NSString *)underscore:(NSString *)string;
{
    NSScanner *scanner = [NSScanner scannerWithString:string];
    scanner.caseSensitive = YES;

    NSCharacterSet *uppercase = [NSCharacterSet uppercaseLetterCharacterSet];
    NSCharacterSet *lowercase = [NSCharacterSet lowercaseLetterCharacterSet];

    NSString *buffer = nil;
    NSMutableString *output = [NSMutableString string];

    while (scanner.isAtEnd == NO) {

        if ([scanner scanCharactersFromSet:uppercase intoString:&buffer]) {
            [output appendString:[buffer lowercaseString]];
        }

        if ([scanner scanCharactersFromSet:lowercase intoString:&buffer]) {
            [output appendString:buffer];
            if (!scanner.isAtEnd)
                [output appendString:@"_"];
        }
    }

    return [NSString stringWithString:output];
}

@end
