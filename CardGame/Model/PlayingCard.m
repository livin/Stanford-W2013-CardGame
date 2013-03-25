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
		if (!([contents length] == 2)) {
			return nil;
		}
		
		NSString* rankString = [contents substringWithRange:NSMakeRange(0, 1)];
		NSString* suit = [contents substringWithRange:NSMakeRange(1, 1)];
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

@end
