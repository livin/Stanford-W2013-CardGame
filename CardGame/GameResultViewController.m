//
//  GameResultViewController.m
//  CardGame
//
//  Created by Vladimir on 07.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortSelectorControl;
@end

@implementation GameResultViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self updateDisplay];
}

- (SEL) sortSelector
{
    NSUInteger index = self.sortSelectorControl.selectedSegmentIndex;
    switch (index) {
        case 0: return @selector(compareByDate:);
        case 1: return @selector(compareByScore:);
        case 2: return @selector(compareByDuration:);
    }
    return nil;
}

- (void) updateDisplay
{
    NSMutableArray* matchGameResults = [[NSMutableArray alloc] init];
    NSMutableArray* setGameResults = [[NSMutableArray alloc] init];
    
    for(GameResult* gameResult in [GameResult allGameResults]) {
        if (gameResult.gameType == GAMETYPE_MATCH) {
            [matchGameResults addObject: gameResult];
        } else if (gameResult.gameType == GAMETYPE_SET) {
            [setGameResults addObject: gameResult];
        }
    }
    
    NSString* matchGameResultsString = [self sortedGameResultsString: matchGameResults header: @"Match Games"];
    NSString* setGameResultsString = [self sortedGameResultsString: setGameResults header: @"Set Games"];
    
    self.display.text = [@[matchGameResultsString, setGameResultsString] componentsJoinedByString: @"\n"];
}

- (NSString*) sortedGameResultsString: (NSArray*) unsortedGameResults header: (NSString*) header
{
    NSArray* results = [unsortedGameResults sortedArrayUsingSelector:[self sortSelector]];
    NSString* gameLines = [results componentsJoinedByString: @"\n"];
    
    NSString* result = [[[header stringByAppendingString: @"\n\n"] stringByAppendingString: gameLines] stringByAppendingString: @"\n"];
    
    return result;
}

- (IBAction)sprtSelectionChanged {
    [self updateDisplay];
}

- (IBAction)resetAllScores:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject: nil forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self updateDisplay];
}

@end
