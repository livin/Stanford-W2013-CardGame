//
//  PlayingCardDeck.m
//  CardGame
//
//  Created by Vladimir on 23.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id) init
{
    if (self = [super init]) {
        for(NSString* suit in [PlayingCard validSuits]) {
            for(int rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard* card = [[PlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                
                [self addCard:card atTop:NO];
            }
        }
    }
    
    return self;
}

@end
