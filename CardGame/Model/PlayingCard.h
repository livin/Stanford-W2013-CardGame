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

- (id) initWithContents: (NSString*)contents;

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString* suit;

@end
