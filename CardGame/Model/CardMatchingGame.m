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
@end

@implementation CardMatchingGame

- (id) init
{
	return nil;
}

- (id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck*) deck
{
	self = [super init];
	
	if (self) {
		for(int i = 0; i < cardCount; i++) {
			[self.cards addObject:[deck drawRandomCard]];
		}
	}
	
	return self;
}

- (NSMutableArray*) cards {
	if (!_cards)
		_cards = [[NSMutableArray alloc] init];
	return _cards;
}

- (Card*) cardAtIndex:(NSUInteger)index
{
	return index < [self.cards count] ? self.cards[index] : nil;
}

- (void) flipCardAtIndex:(NSUInteger)index
{
	Card* card = [self cardAtIndex: index];
	if (!card.isUnplayable) {
		card.faceUp = !card.isFaceUp;
	}
}



@end
