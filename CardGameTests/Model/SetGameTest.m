//
//  SetGameTest.m
//  CardGame
//
//  Created by Vladimir on 08.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "SetGameTest.h"
#import "SetGame.h"
#import "SetCardDeck.h"

@implementation SetGameTest

- (void) testCreation
{
    SetGame* set = [[SetGame alloc] initWithCardCount: 24];
    STAssertNotNil(set, @"Set game should be initialized successfully");
}

@end
