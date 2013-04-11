//
//  SetGameViewController.m
//  CardGame
//
//  Created by Vladimir on 08.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetGame.h"
#import "SetCard.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (void) updateCardButton:(UIButton *)cardButton forCard:(Card *)card
{
    SetCard* setCard = (SetCard*)card;

    cardButton.backgroundColor = card.isFaceUp?[UIColor lightGrayColor]: [UIColor whiteColor];
    cardButton.selected = card.isFaceUp;
    cardButton.enabled = !card.isUnplayable;
    cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    
    // coloring
    UIColor* cardColor = @[[UIColor blackColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor]][setCard.color];
        
    NSMutableParagraphStyle * paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];    
    [paragraphStyle setAlignment: NSTextAlignmentCenter];
    
    NSNumber* strokeWidth = @(0);
    UIColor* strokeColor = [UIColor clearColor];
    UIColor* foregroundColor = cardColor;
    
    if (setCard.shading == SHADING_OPEN) {
        strokeWidth = @(-10.0);
        strokeColor = cardColor;
        foregroundColor = [UIColor clearColor];
    } else if (setCard.shading == SHADING_SHADE) {
        strokeWidth = @(-10.0);
        strokeColor = cardColor;
        foregroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent: 0.3];
    }
    
    NSDictionary* attributes =
        @{ NSForegroundColorAttributeName: foregroundColor,
           NSParagraphStyleAttributeName: paragraphStyle,
           NSStrokeWidthAttributeName: strokeWidth,
           NSStrokeColorAttributeName: strokeColor
           };    
    
    NSMutableAttributedString* a = [[NSMutableAttributedString alloc] initWithString:[card contents] attributes:attributes];
    [cardButton setAttributedTitle: a forState: UIControlStateNormal];
    [cardButton setAttributedTitle: a forState: UIControlStateSelected];
    [cardButton setAttributedTitle: a forState: UIControlStateSelected|UIControlStateDisabled];
}

- (CardMatchingGame*) createNewGame
{
    return [[SetGame alloc] initWithCardCount: 24];
}


@end
