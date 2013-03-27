//
//  Card.m
//  CardGame
//
//  Created by Vladimir on 21.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "Card.h"

@implementation Card

- (NSString*) contents
{
	return nil; // should be defined in subclasses.
}

- (int) match: (NSArray*) cards
{
	return 0;
}

@end
