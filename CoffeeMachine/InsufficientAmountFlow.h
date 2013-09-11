//
//  InsufficientAmountFlow.h
//  PickerViewTest
//
//  Created by dancho on 8/21/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoneyAmount;
@class CoffeeMachineState;
@class Drink;


@interface InsufficientAmountFlow : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *makeDrinkBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelOrderBtn;
- (IBAction)switchToFinalizeFlow:(id)sender;
- (IBAction)switchToDrinkListFlow:(id)sender;

@property Drink* selectedDrink;
@property MoneyAmount* change;
@property CoffeeMachineState* coffeeMachineState;
@property MoneyAmount* userCoins;


@end
