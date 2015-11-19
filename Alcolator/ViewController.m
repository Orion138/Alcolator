//
//  ViewController.m
//  Alcolator
//
//  Created by Nathan Boosinger on 11/15/15.
//  Copyright (c) 2015 Nathan Boosinger. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}

- (IBAction)sliderValueDidChange:(UISlider *)slider {
    slider.value = roundf(slider.value);
    NSLog(@"Slider value changed to %f", slider.value);
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) slider.value]];
    [self updateViewForWine];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    [self updateViewForWine];
}

- (float)calculateByOunces:(float)ounces andPercent:(float)alcoholPercent {
    // First, calculate how much alcohol is in all those beers...
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  // Assume they are 12oz beer bottles
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // Now calculate the equivalent amount of wine...
//    float ouncesInOneWineGlass = 5;  // Wine glasses are usually 5oz
//    float alcoholPercentageOfWine = 0.13;  // 13% is average
    float ouncesOfAlcoholPerDrink = ounces * alcoholPercent;
    float numberOfDrinksForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerDrink;
    return numberOfDrinksForEquivalentAlcoholAmount;
}

- (void)updateViewForWine {
    int wineCalculation = [self calculateByOunces:5 andPercent:0.13];
    [self updateViewWith:wineCalculation andDrinkName:@"Wine"];
}


- (void)updateViewWith:(float)numberOfEquivalentDrinks andDrinkName:(NSString *)drinkName {
    [self.beerPercentTextField resignFirstResponder];
    int numberOfBeers = self.beerCountSlider.value;
    // Decide whether to use "beer"/"beers" and "glass"/"glasses"
    NSString *beerText;
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    
    NSString *wineText;
    if (numberOfEquivalentDrinks == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // Generate the result text, and display it on the label
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %.1f %@ of %@.", nil), numberOfBeers, beerText, [self.beerPercentTextField.text floatValue], numberOfEquivalentDrinks, wineText, drinkName];
    self.resultLabel.text = resultText;
    
    self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"%@(%.1f %@)", drinkName, numberOfEquivalentDrinks, wineText];
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end
