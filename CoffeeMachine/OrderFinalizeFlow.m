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

//@synthesize  drinkLbl;
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
    [self updateCoffeeMachineState];
    self.changeLbl.backgroundColor = [UIColor blueColor];
    self.changeLbl.font =  [UIFont boldSystemFontOfSize:20];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backToDrinkListFlow:)];
    self.navigationItem.leftBarButtonItem = backButton;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}	

-(void)updateCoffeeMachineState{
    if(willGetDrink){
       //self.drinkLbl.text = self.selectedDrink.name;
        float numChange =(float)[change sumOfCoins] / 100;
        self.changeLbl.text = [NSString stringWithFormat:@"%.2f %@",numChange , @"lv"];
        [coffeeMachineState.coins add:userCoins];
        [coffeeMachineState.currentDrinksAmount decreaseDrinkAmount:selectedDrink];
    }
    else {
        //self.drinkLbl.text=@"Take your money";
        self.changeLbl.text=userCoins.description;
        //[coffeeMachineState.coins add:change];
    }
    
}
-(void)backToRootView : (id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
    //ViewController *vc = [[ViewController alloc]init];
    //[self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)backToDrinkListFlow:(id)sender {
    
        //[self.navigationController popToRootViewControllerAnimated:YES];
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
    [self.coffeeMachineState saveStateToFile];
}



@end
