//
//  SetCard.h
//  CardGame
//
//  Created by Vladimir on 07.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

#define SYMBOL_CIRLE 0
#define SYMBOL_TRIANGLE 1
#define SYMBOL_SQUARE 2

#define SETCOLOR_RED 1
#define SETCOLOR_GREEN 2
#define SETCOLOR_BLUE 3

#define SHADING_OPEN 0
#define SHADING_SOLID 1
#define SHADING_SHADE 2

@interface SetCard : Card

+ (BOOL) allValuesSameOrDifferent: (NSArray*)threeItems;

@property (nonatomic) int symbol;
@property (nonatomic) int number;
@property (nonatomic) int color;
@property (nonatomic) int shading;

- (id) initWithNumber: (int)number symbol: (int)symbol color: (int)color shading: (int)shading;

@end
