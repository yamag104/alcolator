//
//  ViewController.m
//  Alcolator
//
//  Created by Yoko Yamaguchi on 8/22/15.
//  Copyright (c) 2015 Yoko Yamaguchi. All rights reserved.
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
        sender.text = nil;
    }
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f",sender.value);
    [self.beerPercentTextField resignFirstResponder];
    
    float floatValue = self.beerCountSlider.value;
    int numberOfBeers = floatValue;
    self.navigationItem.title = [NSString stringWithFormat:@"Wine(%d glasses)",numberOfBeers];
}
- (IBAction)calculatePressed:(id)sender {
    [self.beerPercentTextField resignFirstResponder];
    // first, calculate how much alcohol is in all those beers...
     int numberOfBeers = self.beerCountSlider.value;
     int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
     float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
     float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
     float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
     // now, calculate the equivalent amount of wine...
     float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
     float alcoholPercentageOfWine = 0.13;  // 13% is average
     float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
     float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
     // decide whether to use "beer"/"beers" and "glass"/"glasses"
     float textFieldFloat = [self.beerPercentTextField.text floatValue];
     NSString *beerText;
     if (numberOfBeers == 1) {
     beerText = NSLocalizedString(@"beer", @"singular beer");
     } else {
     beerText = NSLocalizedString(@"beers", @"plural of beer");
     }
     NSString *wineText;
     if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
     wineText = NSLocalizedString(@"glass", @"singular glass");
     } else {
     wineText = NSLocalizedString(@"glasses", @"plural of glass");
     }
     
    // generate the result text, and display it on the label
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText,  textFieldFloat, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    
    self.resultLabel.text = resultText;
    
    int resultNum = numberOfWineGlassesForEquivalentAlcoholAmount;
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d",resultNum]];
}

- (IBAction)buttonPressed:(UIButton *)sender {

}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end
