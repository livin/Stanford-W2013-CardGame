//
//  SetCardDeckTest.m
//  CardGame
//
//  Created by Vladimir on 08.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "SetCardDeckTest.h"
#import "SetCardDeck.h"

@implementation SetCardDeckTest

- (void) testDeckCardCount
{
    SetCardDeck* deck = [[SetCardDeck alloc] init];
    STAssertEquals([deck.cards count], (NSUInteger) 81, @"Should be 81 cards in the deck for Set");
}

@end
