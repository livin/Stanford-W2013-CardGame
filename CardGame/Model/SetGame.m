//
//  SetGame.m
//  CardGame
//
//  Created by Vladimir on 08.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "SetGame.h"
#import "SetCardDeck.h"

@implementation SetGame

- (id) initWithCardCount:(NSUInteger)cardCount
{
    return self = [super initWithCardCount: cardCount maxCardsToOpen: 3 usingDeck: [[SetCardDeck alloc] init]];
}

@end
