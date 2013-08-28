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

@synthesize  drinkLbl;
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateCoffeeMachineState{
    if(willGetDrink){
       self.drinkLbl.text = self.selectedDrink.name;
       self.changeLbl.text = change.description;
        [coffeeMachineState.coins add:userCoins];
    }
    else {
        self.drinkLbl.text=@"Take your money";
        self.changeLbl.text=userCoins.description;
        [coffeeMachineState.coins add:change];
    }
    
}

- (IBAction)backToDrinkListFlow:(id)sender {
        [self.navigationController popToRootViewControllerAnimated:YES];

}
@end
