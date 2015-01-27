//
// APIInflector.m
//
// Copyright (c) 2015 Klaas Pieter Annema (http://annema.me)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
