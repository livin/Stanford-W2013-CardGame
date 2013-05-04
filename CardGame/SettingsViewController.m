//
//  SettingsViewController.m
//  CardGame
//
//  Created by Vladimir on 05.05.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "SettingsViewController.h"
#import "GameResult.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (IBAction)resetAllScores:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject: nil forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
