//
//  PaymentFlow.m
//  PickerViewTest
//
//  Created by dancho on 8/6/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "PaymentFlow.h"
#import "ViewController.h"
#import "DrinksContainer.h"
#import "Withdraw.h"
#import "Coin.h"
#import"MoneyAmount.h"
#import "Withdraw.h"
#import "CoffeeMachineState.h"
#import "Drink.h"
#import "OrderFinalizeFlow.h"
#import "InsufficientAmountFlow.h"
#import "SoundPlayer.h"
#import "Theme.h"

//static NSString *fontName = @"DBLCDTempBlack";

@interface PaymentFlow ()
@property (strong) UIImageView *movingCoin;
@end

@implementation PaymentFlow

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
    [self formatView];
     _userCoins = [[MoneyAmount alloc] init];
   
}

 //on start moving
-(void) moveCoin: (UIImageView *) image
{   
    self.oldCoinPosition = image.center;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panGesture setMaximumNumberOfTouches:1];
    [image addGestureRecognizer:panGesture];
}

//when dragged coin is over the slot image
-(BOOL)didCoinImageIsInSlotImg: (UIView*)coinImage slotImage: (UIView*)slotImage : (int) pixSensitivity
{
    BOOL flag = YES;
    if(coinImage.center.x < _slotImg.center.x - pixSensitivity) flag = false;
    if(coinImage.center.x > _slotImg.center.x + pixSensitivity) flag = false;
    if(coinImage.center.y < _slotImg.center.y - pixSensitivity) flag = false;
    if(coinImage.center.y > _slotImg.center.y + pixSensitivity) flag = false;
    return flag;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)switchBack:(id)sender
{
    ViewController *viewControler = [[ViewController alloc] initWithNibName:@"ViewController"bundle:nil ];
    [[self navigationController ]setNavigationBarHidden:NO animated:YES];
    [self.navigationController pushViewController:viewControler animated:YES];
}

-(void)setCoinInUserCoins:(int)coinValue
{
    Coin *userCoin = [[Coin alloc] init];
    userCoin.value = coinValue;
    [self.userCoins addCoin:userCoin amount:1];
    _sumLbl.text = [NSString stringWithFormat:@"Sum: %d",[self.userCoins sumOfCoins]];
    //[_sumLbl setFont:[UIFont fontWithName:fontName size:20]];
    [_sumLbl setFont:[[Theme sharedTheme] coffeeFontWithSize:20]];

}

-(void)formatView
{
    Theme* theme = [Theme sharedTheme];
    [_sumLbl setFont:[theme coffeeFontWithSize:20]];
    _sumLbl.backgroundColor = [theme lblBackColor];
    _sumLbl.text = @"Sum: 0";
    [_remainingSum setFont:[theme coffeeFontWithSize:20]];
    _remainingSum.backgroundColor = [theme lblBackColor];
    _remainingSum.text = [NSString stringWithFormat:@"Remaining: %d", _selectedDrink.price];
    _backImageView.image = [theme backGroudImage];
    _backImageView.contentMode = UIViewContentModeScaleAspectFill;
}

// switching to OrderFinalizeFlow or InsufficientAmountFlow when inserted coins are enough 
- (void) switchMenu
{
    if( _userCoins.sumOfCoins >= _selectedDrink.price){
        int change = [_userCoins sumOfCoins] - _selectedDrink.price;
        Withdraw* withdraw = [[Withdraw alloc] init];
        withdraw = [_coffeeMachineState.coins withdraw:change];
        if(withdraw.status == SUCCESSFUL){
            OrderFinalizeFlow *orderFinalizeFlow =[ [OrderFinalizeFlow alloc]initWithNibName:@"OrderFinalizeFlow" bundle:nil];
            orderFinalizeFlow.coffeeMachineState = self.coffeeMachineState;
            orderFinalizeFlow.selectedDrink = self.selectedDrink;
            orderFinalizeFlow.change = withdraw.change;
            orderFinalizeFlow.userCoins = self.userCoins;
            orderFinalizeFlow.willGetDrink = YES;
            [self animatedSwitchMenu:orderFinalizeFlow];
            
        }
        else{
            InsufficientAmountFlow *insAmountFlow=[[InsufficientAmountFlow alloc]initWithNibName:@"InsufficientAmountFlow" bundle:nil];
            insAmountFlow.coffeeMachineState = self.coffeeMachineState;
            insAmountFlow.selectedDrink = self.selectedDrink;
            insAmountFlow.change = withdraw.change;
            insAmountFlow.userCoins = self.userCoins;
            [self animatedSwitchMenu:insAmountFlow];
        }
    }
}

-(void)animatedSwitchMenu: (id)flow
{
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:flow animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}

-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer
{
    SoundPlayer* soundDropCoin = [[SoundPlayer alloc]initWithFileName:@"dropCoin" andFileType:@"mp3"];
    SoundPlayer* soundCoinBack = [[SoundPlayer alloc]initWithFileName:@"coinBack" andFileType:@"mp3"];
    UIGestureRecognizerState state = [recognizer state];
    UIImageView *iv = (UIImageView *)recognizer.view;
    if (state == UIGestureRecognizerStateBegan) {
        self.movingCoin = [[UIImageView alloc] initWithFrame:iv.frame];
        _movingCoin.image = iv.image;
        [self.view addSubview:_movingCoin]; // adding on top, no need to call bringSubviewToFront
    }
    else if (state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:_movingCoin.superview];
        
		CGPoint p = CGPointMake(_movingCoin.center.x + translation.x, _movingCoin.center.y + translation.y);
        _movingCoin.center = p;
        [recognizer setTranslation:CGPointZero inView:_movingCoin.superview];
    }
    else {
        if([self didCoinImageIsInSlotImg:_movingCoin slotImage:_slotImg : 20]){ // when the coin is droped in slot
            _movingCoin.center = CGPointMake(_slotImg.center.x,_slotImg.center.y);
            [self rotateImage:_movingCoin];
            _movingCoin = nil;
            [soundDropCoin play];
        } else{ //when the coin is droped not in the slot
            [UIView animateWithDuration:0.2 animations:^{_movingCoin.center = recognizer.view.center;} completion:
             ^(BOOL finished){
                 if (finished) {
                     [soundCoinBack play];
                     [_movingCoin removeFromSuperview];
                      _movingCoin = nil;
                 }
             }];
        }
    }
     
   }

//updating sum of inserted coins
-(void)updateSum: (UIImageView*) image {
    if (image.image == _fiveImg.image){
        [self setCoinInUserCoins:5];
        [self remainingSumOfCoins];
        [self switchMenu];
    }
    if (image.image == _tenImg.image)
    {
        [self setCoinInUserCoins:10];
        [self remainingSumOfCoins];
        [self switchMenu];
    }
    if (image.image == _twentyImg.image)
    {
        [self setCoinInUserCoins:20];
        [self remainingSumOfCoins];
        [self switchMenu];
    }
    if (image.image == _fiftyImg.image)
    {
        [self setCoinInUserCoins:50];
        [self remainingSumOfCoins];
        [self switchMenu];
    }
    if (image.image == _levImg.image)
    {
        [self setCoinInUserCoins:100];
        [self remainingSumOfCoins];
        [self switchMenu];
    }
}

//animated rotation of image
-(void)rotateImage: (UIImageView*) image 
{
    [UIView animateWithDuration:0.5 animations:^{
    [image.layer setValue:@-1.5707 forKeyPath:@"transform.rotation"];
    [image.layer setValue:@0 forKeyPath:@"transform.scale.y"];
        } completion: 
     ^(BOOL finished){
    if (finished) {
        [self updateSum:image];
        [_movingCoin removeFromSuperview];
            }
            
        }
      
      ];
}
-(void)remainingSumOfCoins
{
    int remainingSum = _selectedDrink.price - self.userCoins.sumOfCoins;
    self.remainingSum.text = [NSString stringWithFormat:@"Remaining: %d", remainingSum];

}

@end
