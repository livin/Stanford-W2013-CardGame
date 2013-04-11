//
//  SetCardDeck.m
//  CardGame
//
//  Created by Vladimir on 08.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id) init
{
    self = [super init];
        
    if (self) {
        for(int number = 1; number <= 3; number++) {
            for(int symbol = SYMBOL_CIRLE; symbol <= SYMBOL_SQUARE; symbol++) {
                for(int color = SETCOLOR_RED; color <= SETCOLOR_BLUE; color++) {
                    for(int shading = SHADING_OPEN; shading <= SHADING_SHADE; shading++) {
                        SetCard* card = [[SetCard alloc] initWithNumber: number symbol: symbol color: color shading: shading];
                        [self addCard: card atTop: NO];
                    }
                }
            }
        }
    }    
    return self;
}

@end
