//
//  Deck.m
//  CardGame
//
//  Created by Vladimir on 21.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "Deck.h"

@implementation Deck

- (NSMutableArray *)cards {
	if (!_cards) {
		_cards = [[NSMutableArray alloc] init];
	}
	return _cards;
}

- (void) addCard: (Card*)card atTop:(BOOL)atTop {
	// do nothing here yet.
}

@end
