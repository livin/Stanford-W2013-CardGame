//
//  FlipResultTest.m
//  CardGame
//
//  Created by Vladimir on 12.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "FlipResultTest.h"
#import "FlipResult.h"

@implementation FlipResultTest

- (void) testCreation
{
    FlipResult* none = [FlipResult NoneFlipResult];
    STAssertNotNil(none, @"None flip result should be not nit");
    STAssertEquals(none.type, FLIPRESULT_NONE, @"None flip result type should be correct");
}

@end
