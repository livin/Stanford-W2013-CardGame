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
    SetCard* card = [[SetCard alloc] initWithNumber: 1 symbol: SYMBOL_CIRLE color: SETCOLOR_RED shading: SHADING_OPEN];
    STAssertNotNil(card, @"Card should be created successfully");
}

- (void) testContents
{
    SetCard* card = [[SetCard alloc] initWithNumber:3 symbol: SYMBOL_CIRLE color: SETCOLOR_RED shading: SHADING_OPEN];
    STAssertEqualObjects([card contents], @"●●●", @"Contents of 3 black open circles should be 3 circles string (solid)");
}

- (void) testAllValuesSameOrDifferent
{
    STAssertTrue(([SetCard allValuesSameOrDifferent: @[@(1), @(2), @(3)]]), @"1, 2, 3 are all different");
    STAssertTrue(([SetCard allValuesSameOrDifferent: @[@(1), @(1), @(1)]]), @"1, 1, 1 are all same");
    STAssertFalse(([SetCard allValuesSameOrDifferent: @[@(1), @(1), @(2)]]), @"1, 1, 2 neither all same nor all different");
}

- (void) testMatch
{
    SetCard* c1 = [[SetCard alloc] initWithNumber:1 symbol: SYMBOL_CIRLE color: SETCOLOR_RED shading: SHADING_OPEN];
    SetCard* c2 = [[SetCard alloc] initWithNumber:2 symbol: SYMBOL_CIRLE color: SETCOLOR_RED shading: SHADING_OPEN];
    SetCard* c3 = [[SetCard alloc] initWithNumber:3 symbol: SYMBOL_CIRLE color: SETCOLOR_RED shading: SHADING_OPEN];
    STAssertEquals(([c1 match: @[c2, c3]]), 1, @"Same parameters in all cards, but number varies in all cards - it's a Set");
    
    c1 = [[SetCard alloc] initWithNumber:1 symbol: SYMBOL_CIRLE color: SETCOLOR_RED shading: SHADING_OPEN];
    c2 = [[SetCard alloc] initWithNumber:2 symbol: SYMBOL_SQUARE color: SETCOLOR_RED shading: SHADING_OPEN];
    c3 = [[SetCard alloc] initWithNumber:3 symbol: SYMBOL_CIRLE color: SETCOLOR_RED shading: SHADING_OPEN];
    STAssertEquals(([c1 match: @[c2, c3]]), 0, @"There are two circles - no Set");
}

@end
