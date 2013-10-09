//
//  OrderFinalizeFlow.h
//  PickerViewTest
//
//  Created by dancho on 8/21/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Drink;
@class MoneyAmount;
@class CoffeeMachineState;

@interface OrderFinalizeFlow : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *changeLbl;
@property (strong, nonatomic) IBOutlet UIImageView *backImageView;
@property (strong, nonatomic) IBOutlet UIButton *backToDrinkList;
@property (strong, nonatomic) IBOutlet UIImageView *backImg;
@property UIImageView* explosion;
@property (strong, nonatomic) IBOutlet UIImageView *changeImgView;
@property (strong, nonatomic) IBOutlet UIImageView *readyDrinkImg;
@property (strong, nonatomic) IBOutlet UILabel *infoDrinkLbl;
@property Drink* selectedDrink;
@property MoneyAmount* change;
@property MoneyAmount* userCoins;
@property CoffeeMachineState* coffeeMachineState;
@property BOOL willGetDrink;

-(void)updateCoffeeMachineState;
- (IBAction)backToDrinkListFlow:(id)sender;
-(void)formatView;


@end
