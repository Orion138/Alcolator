//
//  ViewController.h
//  Alcolator
//
//  Created by Nathan Boosinger on 11/15/15.
//  Copyright (c) 2015 Nathan Boosinger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *beerPercentTextField;
@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

//@property (assign) float numberOfWineGlassesForEquivalentAlcoholAmount;
//@property (weak, nonatomic) NSString *wineText;
- (float)calculateByOunces:(float)ounces andPercent:(float)alcoholPercent;
- (void)updateViewWith:(float)numberOfEquivalentDrinks andDrinkName:(NSString *)drinkName;
- (IBAction)buttonPressed:(UIButton *)sender;

@end

