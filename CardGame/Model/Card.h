//
//  Card.h
//  CardGame
//
//  Created by Vladimir on 21.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

- (NSString*) contents;

@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;

@end
