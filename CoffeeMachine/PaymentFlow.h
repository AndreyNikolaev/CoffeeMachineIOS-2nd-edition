//
//  PaymentFlow.h
//  PickerViewTest
//
//  Created by dancho on 8/6/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoffeeMachineState;
@class Drink;
@class MoneyAmount;

int sum;
NSString *result;

@interface PaymentFlow : UIViewController 

@property (strong) CoffeeMachineState *coffeeMachineState;
@property (strong) Drink *selectedDrink;
@property (strong) MoneyAmount *userCoins;

@property (strong, nonatomic) IBOutlet UIButton *fiveBtn;
@property (strong, nonatomic) IBOutlet UILabel *sumLbl;
@property (strong, nonatomic) IBOutlet UIButton *tenBtn;
@property (strong, nonatomic) IBOutlet UIButton *twentyBtn;
@property (strong, nonatomic) IBOutlet UIButton *fiftyBtn;
@property (strong, nonatomic) IBOutlet UIButton *levBtn;

- (IBAction)sumFive:(id)sender;
- (IBAction)sumTen:(id)sender;
- (IBAction)sumTwenty:(id)sender;
- (IBAction)sumFifty:(id)sender;
- (IBAction)sumLev:(id)sender;

@end
