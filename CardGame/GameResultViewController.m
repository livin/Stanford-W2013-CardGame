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
    NSArray* results = [[GameResult allGameResults] sortedArrayUsingSelector:[self sortSelector]];
        
    self.display.text = [results componentsJoinedByString: @"\n"];
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
