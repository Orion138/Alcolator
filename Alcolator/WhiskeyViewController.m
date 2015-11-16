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

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    UISlider *slider = sender;
    slider.value = roundf(slider.value);
    [self buttonPressed:(UIButton *) sender];
    self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"Whiskey(%.1f %@)", self.numberOfWhiskeyGlassesForEquivalentAlcoholAmount, self.whiskeyText];
    NSLog(@"Slider value changed to %f", slider.value);
    [self.beerPercentTextField resignFirstResponder];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  // Assume they are 12oz beer bottles
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWhiskeyGlass = 1;  // a 1oz shot
    float alcoholPercentageOfWhiskey = 0.4;  // 40% is average
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    self.numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    
    NSString *beerText;
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    if (self.numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        self.whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    } else {
        self.whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %.1f %@ of Whiskey.", nil), numberOfBeers, beerText, [self.beerPercentTextField.text floatValue], self.numberOfWhiskeyGlassesForEquivalentAlcoholAmount, self.whiskeyText];
    self.resultLabel.text = resultText;
}

@end
