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
@end

@implementation GameResultViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self updateDisplay];
}

- (void) updateDisplay
{
    self.display.text = [[GameResult allGameResults] componentsJoinedByString: @"\n"];    
}

- (IBAction)resetAllScores:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject: nil forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self updateDisplay];
}

@end
