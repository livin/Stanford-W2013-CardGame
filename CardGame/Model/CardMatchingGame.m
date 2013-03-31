//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Vladimir on 26.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray* cards;
@property (readwrite, nonatomic) int score;
@property (readwrite, strong, nonatomic) NSString* lastFlipResult;
@end

@implementation CardMatchingGame

@synthesize lastFlipResult = _lastFlipResult;

- (id) init
{
	return nil;
}

- (id) initWithCardCount:(NSUInteger)cardCount maxCardsToOpen: (NSUInteger)maxCardsToOpen usingDeck:(Deck*) deck
{
	self = [super init];
	
	if (self) {
		self.matchBonus = 4;
		self.flipCost = 1;
		self.mismatchPenalty = 2;
		
		self.maxCardsToOpen = maxCardsToOpen;				
		
		for(int i = 0; i < cardCount; i++) {
			[self.cards addObject:[deck drawRandomCard]];
		}
	}
	
	return self;
}

- (id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck*) deck
{
	return [self initWithCardCount: cardCount maxCardsToOpen: 2 usingDeck: deck];
}

- (NSMutableArray*) cards {
	if (!_cards)
		_cards = [[NSMutableArray alloc] init];
	return _cards;
}

- (NSString*) lastFlipResult
{
	return _lastFlipResult?_lastFlipResult:@"";
}

- (void) setLastFlipResult:(NSString *)lastFlipResult
{
	_lastFlipResult = lastFlipResult;
	[self.flipHistory addObject: lastFlipResult];
}

- (NSMutableArray*) flipHistory
{
	if (!_flipHistory)
		_flipHistory = [[NSMutableArray alloc] init];	
	return _flipHistory;
}

- (Card*) cardAtIndex:(NSUInteger)index
{
	return index < [self.cards count] ? self.cards[index] : nil;
}

- (void) flipCardAtIndex:(NSUInteger)index
{
	Card* card = [self cardAtIndex: index];
	if (!card.isUnplayable) {
		if (!card.isFaceUp) {
			NSArray* faceUpCards = [self faceUpCards];
			if ([faceUpCards count] + 1 == self.maxCardsToOpen) {
				int matchScore = [card match: faceUpCards];
				if (matchScore) {
					int matchScoreWithBonus = matchScore * self.matchBonus;
					self.score += matchScore * self.matchBonus;
					self.lastFlipResult = [self cardsMatchMessage:card cards: faceUpCards withPoints: matchScoreWithBonus];
				} else {
					self.score -= self.mismatchPenalty;
					self.lastFlipResult = [self cardsMismatchMessage:card cards: faceUpCards withPoints: self.mismatchPenalty];
				}
				
				card.unplayable = YES;
				for(Card* card in faceUpCards) {
					card.unplayable = YES;
				}
			} else {
				self.lastFlipResult = [@"Flipped up " stringByAppendingString: [card contents]];
			}
			
			self.score -= self.flipCost;
		}
		card.faceUp = !card.isFaceUp;
	}
}

- (NSString*) cardsMatchMessage:(Card*) first cards: (NSArray*) cards withPoints: (int) points
{	
	return [NSString stringWithFormat:@"Matched %@ for %d points", [self cardNamesWith:first andCards: cards], points];
}

- (NSString*) cardsMismatchMessage:(Card*) first cards: (NSArray*) cards withPoints: (int) points
{	
	return [NSString stringWithFormat:@"%@ don't match! %d points penalty!", [self cardNamesWith:first andCards: cards], points];
}


- (NSString*) cardNamesWith:(Card*) first andCards: (NSArray*) cards
{
	NSMutableArray* cardNames = [[NSMutableArray alloc] init];
	[cardNames addObject: [first contents]];
	for(Card* card in cards) {
		[cardNames addObject: [card contents]];
	}
	
	NSString* cardsString = [cardNames componentsJoinedByString: @" & "];
	return cardsString;
}

- (NSArray*) faceUpCards
{
	NSMutableArray* facedUpCards = [[NSMutableArray alloc] init];
	for(Card* card in self.cards) {
		if (card.isFaceUp && (!card.isUnplayable)) {
			[facedUpCards addObject: card];
		}
	}
	return facedUpCards;
}



@end
