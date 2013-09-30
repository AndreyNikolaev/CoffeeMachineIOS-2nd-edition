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




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
 

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self formatLabels];
    [self updateCoffeeMachineState]; // updates coffeeMachineState
    self.infoDrinkLbl.text = self.selectedDrink.name.uppercaseString;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backToDrinkListFlow:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)formatLabels
{
    [self.changeLbl setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:20]]; //SUM label with digital style
    [self.infoDrinkLbl setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:20]];
    self.infoDrinkLbl.backgroundColor = [UIColor blueColor];
}

//updates coffeeMachineState and set Sum label and change Image 
-(void)updateCoffeeMachineState
{
    if(_willGetDrink){   //if customer will get drink
        float numChange =(float)[_change sumOfCoins] / 100;
        if(numChange != 0){
            self.changeLbl.text = [NSString stringWithFormat:@"%.2f %@",numChange , @"lv"];
            self.changeLbl.backgroundColor = [UIColor blueColor];
        }else
        {self.changeImgView.hidden = YES;}
        [_coffeeMachineState.coins add:_userCoins];
        [_coffeeMachineState.currentDrinksAmount decreaseDrinkAmount:_selectedDrink];
    }
    else {  // if customer woun't get drink, he had cancelled the order
        self.readyDrinkImg.hidden = YES;
        self.infoDrinkLbl.hidden = YES;
        float numChange =(float)[_userCoins sumOfCoins] / 100;
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
