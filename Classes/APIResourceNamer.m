//
// APIResourceNamer.m
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

#import "APIResourceNamer.h"

@implementation APIResourceNamer

- (id)init;
{
    return [self initWithInflector:nil];
}

- (id)initWithInflector:(APIInflector *)inflector;
{
    if (self = [super init]) {
        _inflector = inflector;
    }

    return self;
}

- (NSString *)nameForResource:(Class)resource;
{
    return [self.inflector underscore:[self stringByRemovingPrefixFromResource:resource]];
}

- (NSString *)pluralizedNameForResource:(Class)resource;
{
    return [self.inflector pluralize:[self nameForResource:resource]];
}

- (NSString *)stringByRemovingPrefixFromResource:(Class)resource;
{
    NSString *className = NSStringFromClass(resource);
    NSRegularExpression *prefixRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Z]+" options:0 error:nil];
    NSRange capitalsRange = [prefixRegularExpression rangeOfFirstMatchInString:className options:0 range:NSMakeRange(0, className.length)];
    NSRange prefixRange = NSMakeRange(0, capitalsRange.length - 1);
    return [className substringFromIndex:prefixRange.length];
}


- (APIInflector *)inflector;
{
    if (!_inflector) {
        _inflector = [[APIInflector alloc] init];
    }

    return _inflector;
}

@end
