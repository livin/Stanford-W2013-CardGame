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
@property (strong, nonatomic) PlayingCardDeck* playingCardDeck;

@end

@implementation CardGameViewController


- (void) setFlipCount:(int)flipCount
{
	_flipCount = flipCount;
	self.flipsLabel.text = [NSString stringWithFormat: @"Flips: %d", self.flipCount];
	NSLog(@"flips updated to %d", self.flipCount);
}

- (PlayingCardDeck*) playingCardDeck
{
	if (!_playingCardDeck) {
		_playingCardDeck = [[PlayingCardDeck alloc] init];
	}
	return _playingCardDeck;
}

- (void) drawRandomCard
{
	Card* card = [self.playingCardDeck drawRandomCard];
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
