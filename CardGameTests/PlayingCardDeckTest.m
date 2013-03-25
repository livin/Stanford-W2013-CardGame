//
//  PlayingCardDeckTest.m
//  CardGame
//
//  Created by Vladimir on 23.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "PlayingCardDeckTest.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardDeckTest

- (void) testCardsCount
{
    PlayingCardDeck* deck = [[PlayingCardDeck alloc] init];
    STAssertEquals((NSUInteger)52, [deck.cards count], @"In playing card deck must be all 52 cards");
}

@end
