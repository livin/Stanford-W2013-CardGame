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

@implementation CardMatchingGameTest

- (void) testCreation
{
	CardMatchingGame* g = [[CardMatchingGame alloc] init];
	STAssertNil(g, @"CardMathingGame should be only initialized with designated initializer");
	
	g = [[CardMatchingGame alloc] initWithCardCount:12 usingDeck:[[PlayingCardDeck alloc] init]];
	STAssertNotNil(g, @"Game should be initialized successfully using designated initializer");
}

@end
