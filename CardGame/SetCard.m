//
//  SetCard.m
//  CardGame
//
//  Created by Vladimir on 07.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (id) initWithNumber: (int)number symbol: (NSString*)symbol color: (int)color shading: (int)shading
{
    self = [super init];
    
    if (self) {
        _number = number;
        _symbol = symbol;
        _color = color;
        _shading = shading;
    }
    
    return self;
}

- (NSString*) contents
{
    NSString* s = @"";
    for(int i = 0; i < self.number; i++) {
        s = [s stringByAppendingString: self.symbol];
    }
    return s;
}

@end
