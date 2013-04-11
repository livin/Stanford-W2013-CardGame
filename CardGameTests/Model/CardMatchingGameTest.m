//
//  CardMatchingGameTest.m
//  CardGame
//
//  Created by Vladimir on 25.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "CardMatchingGameTest.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "MockDeck.h"
#import "PlayingCard.h"
#import "FlipResult.h"

@implementation CardMatchingGameTest

- (void) testCreation
{
	CardMatchingGame* g = [[CardMatchingGame alloc] init];
	STAssertNil(g, @"CardMathingGame should be only initialized with designated initializer");
	
	g = [[CardMatchingGame alloc] initWithCardCount:12 usingDeck:[[PlayingCardDeck alloc] init]];
	STAssertNotNil(g, @"Game should be initialized successfully using designated initializer");
	STAssertNotNil([g cardAtIndex: 0], @"Should be a card at index 0");
	STAssertNotNil([g cardAtIndex: 1], @"Should be a card at index 1");
}

- (void) testCardAtIndex
{
	Deck* deck = [[MockDeck alloc] init];
	
	Card* c1 = [[PlayingCard alloc] initWithContents: @"2♦"];
	Card* c2 = [[PlayingCard alloc] initWithContents: @"3♦"];
	
	[deck addCard: c1 atTop: NO];
	[deck addCard: c2 atTop: NO];
	
	CardMatchingGame* game = [[CardMatchingGame alloc] initWithCardCount: 2 usingDeck: deck];
	
	STAssertEquals(c1, [game cardAtIndex: 0], @"Card at index should return first card for index 0");
	STAssertEquals(c2, [game cardAtIndex: 1], @"Card at index should return second card for index 1");
}

- (void) testUserCanFlipOnlyPlayableCards
{
	Deck* deck = [[MockDeck alloc] init];
	
	Card* playableCard = [[PlayingCard alloc] initWithContents: @"A♦"];
	playableCard.faceUp = NO;
	playableCard.unplayable = NO;
	
	Card* unplayableCard = [[PlayingCard alloc] initWithContents: @"3♦"];
	unplayableCard.faceUp = YES;
	unplayableCard.unplayable = YES;
	
	[deck addCard: playableCard atTop: NO];
	[deck addCard: unplayableCard atTop: NO];
	
	CardMatchingGame* game = [[CardMatchingGame alloc] initWithCardCount: 2 usingDeck: deck];

	[game flipCardAtIndex: 1];
	STAssertTrue(unplayableCard.isFaceUp == YES, @"Flipping second unplayable card should do nothing, card shouldn't face down");
	
	[game flipCardAtIndex: 0];
	STAssertTrue(playableCard.isFaceUp == YES, @"Flipping first playable card should work, and card should be faced up");	
}

- (void) testGameScoresWhenTwoCardsOpened
{
	Card* ace = [[PlayingCard alloc] initWithContents: @"A♦"];
	Card* three = [[PlayingCard alloc] initWithContents: @"3♦"];
	[self assertFlipCardsGame:@[ace, three] scores: 2 because: @"Score should be 2 (4 for matching 2 suits, -2 for two flips)"];
}

- (void) testGameScoresDownWhenCardsMismatch
{
	Card* c1 = [[PlayingCard alloc] initWithContents: @"A♦"];
	Card* c2 = [[PlayingCard alloc] initWithContents: @"3♣"];
	[self assertFlipCardsGame:@[c1, c2] scores: -4 because: @"Score should be -4 (-2 for mismatch, -2 for two flips)"];
}

- (void) testGame3Cards
{
	Card* c1 = [[PlayingCard alloc] initWithContents: @"A♦"];
	Card* c2 = [[PlayingCard alloc] initWithContents: @"3♦"];
	Card* c3 = [[PlayingCard alloc] initWithContents: @"2♦"];
	[self assertFlipCardsGame:@[c1, c2, c3] maxCardsToOpen: 3 scores: 21 because: @"Score should be 21 (24 for match 3 suits, -3 for two flips)"];

	c1 = [[PlayingCard alloc] initWithContents: @"A♦"];
	c2 = [[PlayingCard alloc] initWithContents: @"3♦"];
	c3 = [[PlayingCard alloc] initWithContents: @"7♣"];
	[self assertFlipCardsGame:@[c1, c2, c3] maxCardsToOpen: 3 scores: 1 because: @"Score should be -2 (4 for match 2 suits, -3 for two flips)"];
}

- (void) testLastFlipResultAndFlipHistory
{
	Deck* deck = [[MockDeck alloc] init];

	Card* c1 = [[PlayingCard alloc] initWithContents: @"A♦"];
	Card* c2 = [[PlayingCard alloc] initWithContents: @"3♦"];
	Card* c3 = [[PlayingCard alloc] initWithContents: @"2♣"];
	Card* c4 = [[PlayingCard alloc] initWithContents: @"3♦"];
	
	NSArray* cards = @[c1, c2, c3, c4];
	
	for(Card* card in cards) {
		[deck addCard: card atTop: NO];
	}
	
	CardMatchingGame* game = [[CardMatchingGame alloc] initWithCardCount: [cards count] usingDeck: deck];
	
	[game flipCardAtIndex: 0];
    FlipResult* lastFlipResult = [game lastFlipResult];
    STAssertEquals(lastFlipResult.type, FLIPRESULT_FLIPPED_UP, @"Flipped up");
    STAssertEqualObjects(lastFlipResult.cards, @[c1], @"A♦");
	
	[game flipCardAtIndex: 1];
    lastFlipResult = [game lastFlipResult];
    STAssertEquals(lastFlipResult.type, FLIPRESULT_MATCH, @"Matched");
    NSArray* c1c2 = @[c2,c1];
    STAssertEqualObjects(lastFlipResult.cards, c1c2, @"3♦ & A♦");
    STAssertEquals(lastFlipResult.points, 4, @"for 4 points");

	[game flipCardAtIndex: 2];
    lastFlipResult = [game lastFlipResult];
    FlipResult* thirdFlipResult = lastFlipResult;
    STAssertEquals(lastFlipResult.type, FLIPRESULT_FLIPPED_UP, @"Flipped up");
    STAssertEqualObjects(lastFlipResult.cards, @[c3], @"2♣");
	
	[game flipCardAtIndex: 3];
    lastFlipResult = [game lastFlipResult];
    STAssertEquals(lastFlipResult.type, FLIPRESULT_MISMATCH, @"Don't match");
    NSArray* c3c4 = @[c4,c3];
    STAssertEqualObjects(lastFlipResult.cards, c3c4, @"3♦ & 2♣");
    STAssertEquals(lastFlipResult.points, 2, @"2 points penalty");
		
	STAssertEquals([game.flipHistory count], (NSUInteger)4, @"Game now should have flip history of 4 items");
	STAssertEqualObjects(game.flipHistory[2], thirdFlipResult, @"The third item of flip (index=2) should be 'Flipped up 2♣'");
}

- (void) assertFlipCardsGame: (NSArray*) cards scores: (int) score because: (NSString*) description
{
	[self assertFlipCardsGame:cards maxCardsToOpen: 2 scores: score because: description];
}

- (void) assertFlipCardsGame: (NSArray*) cards maxCardsToOpen: (int) maxCards scores: (int) score because: (NSString*) description
{
	Deck* deck = [[MockDeck alloc] init];
	
	for(Card* card in cards) {
		[deck addCard: card atTop: NO];
	}
	
	CardMatchingGame* game = [[CardMatchingGame alloc] initWithCardCount: [cards count] maxCardsToOpen: maxCards usingDeck: deck];

	for(int i = 0; i < [cards count]; i++) {
		[game flipCardAtIndex: i];
	}
	
	STAssertEquals(game.score, score, description);
	for(Card* card in cards) {
		STAssertTrue(card.isUnplayable, [NSString stringWithFormat: @"Card %@ card should be unplayable", [card contents]]);
	}	
}

@end
