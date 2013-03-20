//
//  Deck.h
//  CardGame
//
//  Created by Vladimir on 21.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

@property (nonatomic) NSMutableArray* cards;

- (void) addCard: (Card*)card atTop:(BOOL)atTop;

@end
