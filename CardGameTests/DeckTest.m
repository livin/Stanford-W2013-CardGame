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
	STAssertEquals((NSUInteger)0, deck.cards.count, @"There should be no cards in empty deck");
}

- (void)testAddCard
{
	Deck* deck = [[Deck alloc] init];
	Card* card = [[Card alloc] init];
		
	[deck addCard: card atTop: YES];
	STAssertEquals((NSUInteger)1, deck.cards.count, @"One card should be here now");
}

- (void)testAddCardAtTop
{
	Deck* deck = [[Deck alloc] init];

	Card* cardOne = [[Card alloc] init];
	Card* cardTwo = [[Card alloc] init];
    
	[deck addCard: cardOne atTop: NO];
    [deck addCard: cardTwo atTop: YES];
    
    STAssertTrue([deck.cards objectAtIndex:0] == cardTwo, @"At the top must be card No. 2");
}

- (void) testDrawRandomCard
{
	Deck* deck = [[Deck alloc] init];
    
	Card* cardOne = [[Card alloc] init];
	Card* cardTwo = [[Card alloc] init];
    
	[deck addCard: cardOne atTop: NO];
    [deck addCard: cardTwo atTop: NO];
    
    STAssertEquals((NSUInteger)2, deck.cards.count, @"Should be 2 card in the deck at the beginning");
    Card* aRandomCard = [deck drawRandomCard];
    STAssertEquals((NSUInteger)1, deck.cards.count, @"After draw random card - only 1 card must be left in the deck");
}

@end
