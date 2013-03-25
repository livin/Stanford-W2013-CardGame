//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Vladimir on 26.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck*) deck;
- (void) flipCardAtIndex:(NSUInteger)index;
- (Card*) cardAtIndex:(NSUInteger)index;
@property (readonly, nonatomic) int score;

@end
