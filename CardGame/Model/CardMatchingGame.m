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
@property (readwrite, strong, nonatomic) FlipResult* lastFlipResult;
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

- (FlipResult*) lastFlipResult
{
	return _lastFlipResult?_lastFlipResult:[FlipResult NoneFlipResult];
}

- (void) setLastFlipResult:(FlipResult*)lastFlipResult
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
                
                NSMutableArray* allCards = [[NSMutableArray alloc] init];
                [allCards addObject: card];
                [allCards addObjectsFromArray: faceUpCards];                
                
				if (matchScore) {
					int matchScoreWithBonus = matchScore * self.matchBonus;
					self.score += matchScore * self.matchBonus;
					self.lastFlipResult = [[FlipResult alloc] initWithType: FLIPRESULT_MATCH cards: allCards points: matchScoreWithBonus];
				} else {
					self.score -= self.mismatchPenalty;
					self.lastFlipResult = [[FlipResult alloc] initWithType: FLIPRESULT_MISMATCH cards: allCards points: self.mismatchPenalty];
				}
				
				card.unplayable = YES;
				for(Card* card in faceUpCards) {
					card.unplayable = YES;
				}
			} else {
				self.lastFlipResult = [[FlipResult alloc] initWithType:FLIPRESULT_FLIPPED_UP cards: @[card] points: 0];
			}
			
			self.score -= self.flipCost;
		}
		card.faceUp = !card.isFaceUp;
	}
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
