//
//  PlayingCard.m
//  CardGame
//
//  Created by Vladimir on 23.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

+ (NSArray*)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank {
    return [[self rankStrings] count] - 1;
}

+ (NSArray*)validSuits
{
    return @[@"♥", @"♦", @"♠", @"♣"];
}

- (id) initWithContents: (NSString*)contents
{
	self = [self init];
	
	if (self) {
		NSUInteger length = [contents length];
		if (!(length == 2 || length == 3)) {
			return nil;
		}
		
		NSString* rankString = [contents substringWithRange:NSMakeRange(0, length-1)]; // rank is all first chars minus last one
		NSString* suit = [contents substringWithRange:NSMakeRange(length-1, 1)]; // suit is last char
		self.rank = [[PlayingCard rankStrings] indexOfObject:rankString];
		self.suit = suit;
	}
	
	return self;
}

- (NSString*) suit
{
    return _suit?_suit:@"?";
}

- (void) setSuit:(NSString*) aSuit
{
    if ([[PlayingCard validSuits] containsObject:aSuit]) {
        _suit = aSuit;
    }
}

- (void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (NSString*) contents
{
    NSString* rankString = [PlayingCard rankStrings][self.rank];
    return [rankString stringByAppendingString: self.suit];
}

- (int) match: (NSArray*) cards
{
	if ([cards count] == 1) {
		PlayingCard* otherCard = [cards lastObject];
		if ([self.suit isEqualToString: otherCard.suit]) {
			return 1;
		}
	}
	
	return 0;
}

@end
