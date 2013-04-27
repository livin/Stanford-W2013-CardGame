//
//  CardGameViewController.m
//  CardGame
//
//  Created by Vladimir on 21.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "GameResult.h"
#import "FlipResult.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipResultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardsToOpenControl;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame* game;
@property (nonatomic) BOOL firstFlipMade;
@property (strong, nonatomic) GameResult* gameResult;
@end

@implementation CardGameViewController


- (void) setFlipCount:(int)flipCount
{
	_flipCount = flipCount;
	self.flipsLabel.text = [NSString stringWithFormat: @"Flips: %d", self.flipCount];
	NSLog(@"flips updated to %d", self.flipCount);
}

- (void) setCardButtons:(NSArray *)cardButtons
{
	_cardButtons = cardButtons;
	[self updateUI];
}

+ (UIImage*) cardBackImage
{
	return [UIImage imageNamed:@"cardback.png"];
}

- (void)updateCardButton:(UIButton *)cardButton forCard:(Card *)card
{
    [cardButton setTitle: [card contents] forState: UIControlStateSelected];
    [cardButton setTitle: [card contents] forState: UIControlStateSelected|UIControlStateDisabled];
    [cardButton setImage: card.isFaceUp?nil:[CardGameViewController cardBackImage]
                forState: UIControlStateNormal];
    cardButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    cardButton.selected = card.faceUp;
    cardButton.enabled = !card.isUnplayable;
    cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
}

- (void) updateUI
{
	for(UIButton* cardButton in self.cardButtons) {
		NSUInteger index = [self.cardButtons indexOfObject: cardButton];
		Card* card = [self.game cardAtIndex: index];
		
		[self updateCardButton:cardButton forCard:card];
	}
	
	self.scoreLabel.text = [NSString stringWithFormat: @"Score: %d", self.game.score];
	
	[self updateLastFlipMessage: self.game.lastFlipResult pastFlip: NO];
	
	self.cardsToOpenControl.enabled = !self.firstFlipMade;
	
	
	int flipsInHistory = [self.game.flipHistory count];
	[self.historySlider setMaximumValue: flipsInHistory?(flipsInHistory-1):0];
	[self.historySlider setValue: self.historySlider.maximumValue];
}

- (void) updateLastFlipMessage: (FlipResult*) flipResult pastFlip: (BOOL) pastFlip
{
    NSAttributedString* flipResultContents = [self cardMatchMessageForFlipResult: flipResult];
    self.lastFlipResultLabel.attributedText = [self wrapFlipResultMessageStyles: flipResultContents];
    self.lastFlipResultLabel.alpha = pastFlip? 0.55 : 1;
}

- (NSAttributedString*) wrapFlipResultMessageStyles: (NSAttributedString*) message
{
    NSMutableAttributedString* s = [[NSMutableAttributedString alloc] initWithAttributedString: message];
    
    NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    
    [s addAttributes: @{ NSFontAttributeName: [UIFont systemFontOfSize: 14], NSParagraphStyleAttributeName: paragraph}
               range: NSMakeRange(0, s.string.length)];
    
    return s;
}

- (NSAttributedString*) cardMatchMessageForFlipResult: (FlipResult*) flipResult
{
    switch (flipResult.type) {
        case FLIPRESULT_FLIPPED_UP:
            return [self flippedUpMessage: flipResult.cards[0]];
        case FLIPRESULT_MATCH:
            return [self cardsMatchMessage: flipResult.cards withPoints: flipResult.points];
        case FLIPRESULT_MISMATCH:
            return [self cardsMismatchMessage: flipResult.cards withPoints: flipResult.points];
    }
    return [[NSMutableAttributedString alloc] initWithString: @""];
}

- (NSAttributedString*) flippedUpMessage: (Card*) card
{
    NSMutableAttributedString* s = [[NSMutableAttributedString alloc] init];
    [s appendAttributedString: [[NSMutableAttributedString alloc] initWithString: @"Flipped up "]];
    [s appendAttributedString: [self cardsUnionMessage: @[card]]];
    return s;
}

- (NSAttributedString*) cardsMatchMessage: (NSArray*) cards withPoints: (int) points
{
    NSMutableAttributedString* s = [[NSMutableAttributedString alloc] init];
    [s appendAttributedString: [[NSMutableAttributedString alloc] initWithString: @"Matched "]];
    [s appendAttributedString: [self cardsUnionMessage: cards]];
    NSString* forPointsString = [NSString stringWithFormat: @" for %d points", points];
    [s appendAttributedString: [[NSMutableAttributedString alloc] initWithString: forPointsString]];    
    return s;
}

- (NSAttributedString*) cardsMismatchMessage:(NSArray*) cards withPoints: (int) points
{
    NSMutableAttributedString* s = [[NSMutableAttributedString alloc] init];
    [s appendAttributedString: [self cardsUnionMessage: cards]];
    NSString* dontMatchString = [NSString stringWithFormat: @" don't match! %d points penalty!", points];
    [s appendAttributedString: [[NSMutableAttributedString alloc] initWithString: dontMatchString]];
    return s;
}

- (NSAttributedString*) cardsUnionMessage:(NSArray*) cards
{
    NSMutableAttributedString* s = [[NSMutableAttributedString alloc] init];    
    int lastCardNumber = [cards count];
    int currentCardNumber = 1;
    for (Card* card in cards) {
        [s appendAttributedString: [self cardString: card]];
        if (currentCardNumber < lastCardNumber) {
            [s appendAttributedString: [[NSMutableAttributedString alloc] initWithString: @" & "]];
        }
    }
    return s;
}

- (NSAttributedString*) cardString:(Card*) card
{
    return [[NSMutableAttributedString alloc] initWithString: [card contents]];
}

- (CardMatchingGame*) createNewGame
{
    Deck* deck = [[PlayingCardDeck alloc] init];
    return [[CardMatchingGame alloc] initWithCardCount: [self.cardButtons count] usingDeck: deck];
}

- (CardMatchingGame*) game
{
	if (!_game) {
		_game = [self createNewGame];
		self.firstFlipMade = NO;
	}
	return _game;
}

- (GameResult*) gameResult
{
    if (!_gameResult)
        _gameResult = [[GameResult alloc] init];
    
    return _gameResult;
}

- (IBAction)flipCard:(UIButton *)sender {
	self.firstFlipMade = YES;
	NSUInteger index = [self.cardButtons indexOfObject: sender];
	[self.game flipCardAtIndex: index];
	self.flipCount++;
    self.gameResult.score = self.game.score;
	[self updateUI];
}

- (IBAction)deal:(UIButton *)sender {
	self.game = nil;
    self.gameResult = nil;
	self.flipCount = 0;
	[self updateUI];
}

- (IBAction)changedCardsToOpen:(UISegmentedControl *)sender {
	int cardsToOpen = self.cardsToOpenControl.selectedSegmentIndex == 0 ? 2 : 3;
	self.game.maxCardsToOpen = cardsToOpen;
}

- (IBAction)historySlide:(UISlider *)sender {
	int index = self.historySlider.value;

	if ([self.game.flipHistory count]) {
		BOOL pastFlip = index < ([self.game.flipHistory count] - 1);		
        [self updateLastFlipMessage: self.game.flipHistory[index] pastFlip: pastFlip];
	}
}

@end
