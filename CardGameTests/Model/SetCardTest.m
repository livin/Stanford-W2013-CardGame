//
//  SetCardTest.m
//  CardGame
//
//  Created by Vladimir on 07.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "SetCardTest.h"
#import "SetCard.h"

@implementation SetCardTest

- (void) testCreation
{
    SetCard* card = [[SetCard alloc] initWithNumber: 1 symbol: SYMBOL_CIRLE color: SETCOLOR_BLACK shading: SHADING_OPEN];
    STAssertNotNil(card, @"Card should be created successfully");
}

- (void) testContents
{
    SetCard* card = [[SetCard alloc] initWithNumber:3 symbol: SYMBOL_CIRLE color: SETCOLOR_BLACK shading: SHADING_OPEN];
    STAssertEqualObjects([card contents], @"○○○", @"Contents of 3 black open circles should be 3 circles string");
}

@end
