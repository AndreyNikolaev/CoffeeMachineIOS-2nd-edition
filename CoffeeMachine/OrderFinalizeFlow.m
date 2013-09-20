//
//  OrderFinalizeFlow.m
//  PickerViewTest
//
//  Created by dancho on 8/21/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "OrderFinalizeFlow.h"
#import "Drink.h"
#import "CoffeeMachineState.h"
#import "MoneyAmount.h"
#import "InsufficientAmountFlow.h"
#import "ViewController.h"



@interface OrderFinalizeFlow ()

@end

@implementation OrderFinalizeFlow

@synthesize selectedDrink;
@synthesize change;
@synthesize coffeeMachineState;
@synthesize userCoins;
@synthesize willGetDrink;
@synthesize backImg;
@synthesize changeImgView;
@synthesize readyDrinkImg;
@synthesize changeLbl;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//Custom initialization
    }
    return self;
}
 

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateCoffeeMachineState]; // updates coffeeMachineState
    [self.changeLbl setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:20]]; //SUM label with digital style
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backToDrinkListFlow:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}	

//updates coffeeMachineState and set Sum label and change Image 
-(void)updateCoffeeMachineState{
    if(willGetDrink){   //if customer will get drink
        float numChange =(float)[change sumOfCoins] / 100;
        NSLog(@"font must be changed");
        if(numChange != 0){
            self.changeLbl.text = [NSString stringWithFormat:@"%.2f %@",numChange , @"lv"];
            self.changeLbl.backgroundColor = [UIColor blueColor];
        }else
        {self.changeImgView.hidden = YES;}
        [coffeeMachineState.coins add:userCoins];
        [coffeeMachineState.currentDrinksAmount decreaseDrinkAmount:selectedDrink];
    }
    else {  // if customer woun't get drink, he had cancelled the order
        self.readyDrinkImg.hidden = YES;
        float numChange =(float)[userCoins sumOfCoins] / 100;
        self.changeLbl.text =  [NSString stringWithFormat:@"%.2f %@",numChange , @"lv"];
        self.changeImgView.hidden = NO;
        self.changeLbl.backgroundColor = [UIColor blueColor];
         }
    
}

//switching back to DrinkListFlow with animations
- (IBAction)backToDrinkListFlow:(id)sender {
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0.375];
    [self.navigationController popToRootViewControllerAnimated:NO];
    [UIView commitAnimations];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.coffeeMachineState saveStateToFile];//saving coffeeMachinetate into file 
}





@end
