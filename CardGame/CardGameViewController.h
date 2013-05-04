//
//  CardGameViewController.h
//  CardGame
//
//  Created by Vladimir on 21.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "Card.h"
#import "GameResult.h"

@interface CardGameViewController : UIViewController

- (CardMatchingGame*) createNewGame;
- (void)updateCardButton:(UIButton *)cardButton forCard:(Card *)card;
- (GameResult*) createGameResult;

@end
