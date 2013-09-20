//
//  InsufficientAmountFlow.m
//  PickerViewTest
//
//  Created by dancho on 8/21/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "InsufficientAmountFlow.h"
#import "OrderFinalizeFlow.h"
#import "ViewController.h"

@interface InsufficientAmountFlow ()

@end

@implementation InsufficientAmountFlow

@synthesize selectedDrink;
@synthesize coffeeMachineState;
@synthesize change;
@synthesize cancelOrderBtn;
@synthesize makeDrinkBtn;
@synthesize userCoins;
@synthesize notEnCoins;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"admCoffee.jpg"]];
 // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.notEnCoins.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]; // changing style of label
    self.notEnCoins.shadowColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//switch to finalize flow, type: "make drink, don't return coins
- (IBAction)switchToFinalizeFlow:(id)sender {     
    OrderFinalizeFlow *orderFinalizeFlow = [[OrderFinalizeFlow alloc]initWithNibName:@"OrderFinalizeFlow" bundle:nil];
    orderFinalizeFlow.coffeeMachineState =self.coffeeMachineState;
    orderFinalizeFlow.selectedDrink = self.selectedDrink;
    orderFinalizeFlow.change = self.change;
    orderFinalizeFlow.userCoins=self.userCoins;
    orderFinalizeFlow.willGetDrink=YES;// shows to orderFinalizeFlow that the custumer woun't get drink
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:orderFinalizeFlow animated:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];

}

//switch to finalize flow, type: "don't make drink, return my coins", the name of method is bad, must be changed
- (IBAction)switchToDrinkListFlow:(id)sender {
    OrderFinalizeFlow *orderFinalizeFlow = [[OrderFinalizeFlow alloc]initWithNibName:@"OrderFinalizeFlow" bundle:nil];
    orderFinalizeFlow.coffeeMachineState =self.coffeeMachineState;
    orderFinalizeFlow.selectedDrink = self.selectedDrink;
    orderFinalizeFlow.change = self.change;
    orderFinalizeFlow.userCoins=self.userCoins;
    orderFinalizeFlow.willGetDrink=NO; // shows to orderFinalizeFlow that the custumer woun't get drink
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:orderFinalizeFlow animated:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}

@end











