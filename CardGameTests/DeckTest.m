//
//  DeckTest.m
//  CardGame
//
//  Created by Vladimir on 21.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "DeckTest.h"
#import "Deck.h"
#import "Card.h"

@implementation DeckTest

- (void)testGetCardsForEmptyDeck {
	Deck* deck = [[Deck alloc] init];
	STAssertEquals((NSUInteger)0, [deck.cards count], @"There should be no cards in empty deck");
}

- (void)testAddCard
{
	Deck* deck = [[Deck alloc] init];
	Card* card = [[Card alloc] init];
		
	[deck addCard: card atTop: YES];
	STAssertEquals((NSUInteger)1, [[deck cards] count], @"One card should be here now");
}

@end
