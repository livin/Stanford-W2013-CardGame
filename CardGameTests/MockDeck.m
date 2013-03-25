//
//  MockDeck.m
//  CardGame
//
//  Created by Vladimir on 26.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "MockDeck.h"

@implementation MockDeck

// draws top card from the deck
- (Card*) drawRandomCard
{
	Card* card = nil;
	
	if ([self.cards count]) {
		card = [self.cards objectAtIndex: 0];
		[self.cards removeObjectAtIndex: 0];
	}
	
	return card;
}

@end
