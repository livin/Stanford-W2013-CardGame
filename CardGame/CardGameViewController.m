//
//  CardGameViewController.m
//  CardGame
//
//  Created by Vladimir on 21.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck* deck;

@end

@implementation CardGameViewController


- (void) setFlipCount:(int)flipCount
{
	_flipCount = flipCount;
	self.flipsLabel.text = [NSString stringWithFormat: @"Flips: %d", self.flipCount];
	NSLog(@"flips updated to %d", self.flipCount);
}

- (Deck*) deck
{
	if (!_deck) {
		_deck = [[PlayingCardDeck alloc] init];
	}
	return _deck;
}

- (void) drawRandomCard
{
	Card* card = [self.deck drawRandomCard];
	if (card) {
		[self.cardButton setTitle:[card contents] forState:UIControlStateSelected];
	}
}

- (IBAction)flipCard:(UIButton *)sender {
	[self drawRandomCard];
	sender.selected = !sender.isSelected;
	self.flipCount++;
}

@end
