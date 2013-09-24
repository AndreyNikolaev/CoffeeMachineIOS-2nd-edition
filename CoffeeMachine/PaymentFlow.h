//
//  PaymentFlow.h
//  PickerViewTest
//
//  Created by dancho on 8/6/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@class CoffeeMachineState;
@class Drink;
@class MoneyAmount;

int sum;
NSString *result;

@interface PaymentFlow : UIViewController 

@property (strong) CoffeeMachineState *coffeeMachineState;
@property (strong) Drink *selectedDrink;
@property (strong) MoneyAmount *userCoins;

@property (strong, nonatomic) IBOutlet UIImageView *coinImg;
@property (strong, nonatomic) IBOutlet UIImageView *tenImg;
@property (strong, nonatomic) IBOutlet UIImageView *twentyImg;
@property (strong, nonatomic) IBOutlet UIImageView *levImg;

@property  CGPoint oldCoinPosition;

@property (strong, nonatomic) IBOutlet UIImageView *fiftyImg;
@property (strong, nonatomic) IBOutlet UILabel *sumLbl;
@property (strong, nonatomic) IBOutlet UIImageView *fiveImg;
@property (strong, nonatomic) IBOutlet UIImageView *slotImg;




-(void)rotateImage: (UIImageView*) image;
-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
-(void) moveCoin: (UIImageView*) image;
-(void)addImageSubView: (UIImageView*) image;
-(BOOL)didCoinImageIsInSlotImg: (UIImageView*)coinImage: (UIImageView*)slotImage;
-(void)updateSum: (UIImageView*) image;
-(void)moveImageBack :(UIImageView*)image;
-(void)rotateImageBack: (UIImageView*) image;
-(void)animatedSwitchMenu: (id)flow;
@end
