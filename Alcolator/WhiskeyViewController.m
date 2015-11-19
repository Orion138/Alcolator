//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Nathan Boosinger on 11/15/15.
//  Copyright (c) 2015 Nathan Boosinger. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

- (IBAction)sliderValueDidChange:(UISlider *)slider {
    slider.value = roundf(slider.value);
    NSLog(@"Slider value changed to %f", slider.value);
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) slider.value]];
    [self updateViewForWhiskey];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    [self updateViewForWhiskey];
}

- (void)updateViewForWhiskey {
    int calculation = [self calculateByOunces:1.5 andPercent:0.4];
    [self updateViewWith:calculation andDrinkName:@"Whiskey"];
}

@end
