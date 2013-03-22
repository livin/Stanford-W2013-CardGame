//
//  PlayingCard.h
//  CardGame
//
//  Created by Vladimir on 23.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

+ (NSUInteger) maxRank;
+ (NSArray*)validSuits;

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString* suit;

- (NSString*) contents;

@end
