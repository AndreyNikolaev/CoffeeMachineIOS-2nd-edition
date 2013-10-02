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
@interface PaymentFlow ()

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
     _userCoins = [[MoneyAmount alloc] init];
   
}

 //on start moving
-(void) moveCoin: (UIImageView *) image
{   
    self.oldCoinPosition = image.center;
    [self addImageSubView:image];
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
    _sumLbl.text = [NSString stringWithFormat:@"%d",[self.userCoins sumOfCoins]];
    [_sumLbl setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:20]];
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
    SoundPlayer* sound = [[SoundPlayer alloc]init];
    if([recognizer state] == UIGestureRecognizerStateBegan){
        [self moveCoin:recognizer.view];
        [self.view bringSubviewToFront:recognizer.view];
    }
    if(recognizer.view == _fiveImg || recognizer.view == _tenImg || recognizer.view == _twentyImg || recognizer.view == _fiftyImg || recognizer.view == _levImg) {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        recognizer.view.center=CGPointMake(recognizer.view.center.x+translation.x, recognizer.view.center.y+ translation.y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view];
        if([recognizer state] == UIGestureRecognizerStateEnded){
            if([self didCoinImageIsInSlotImg:recognizer.view slotImage:_slotImg : 20]){ // when the coin is near the slot
                recognizer.view.center = CGPointMake(_slotImg.center.x,_slotImg.center.y);
                [self rotateImage:recognizer.view];
                sound.fileName = @"dropCoin";
                sound.fileType = @"mp3";
                [sound play];
            }
            else  recognizer.view.center = _oldCoinPosition;
            sound.fileName = @"coinBack";
            sound.fileType = @"mp3";
            [sound play];
        }
    }
}

//updating sum of inserted coins
-(void)updateSum: (UIImageView*) image {
    if (image == _fiveImg){
        [self setCoinInUserCoins:5];
        [self switchMenu];
    }
    if (image == _tenImg)
    {
        [self setCoinInUserCoins:10];
        [self switchMenu];
    }
    if (image == _twentyImg)
    {
        [self setCoinInUserCoins:20];
        [self switchMenu];
    }
    if (image == _fiftyImg)
    {
        [self setCoinInUserCoins:50];
        [self switchMenu];
    }
    if (image== _levImg)
    {
        [self setCoinInUserCoins:100];
        [self switchMenu];
    }
}

//animated rotation of image
-(void)rotateImage: (UIImageView*) image 
{
        [UIView animateWithDuration:0.5 animations:^{
            [image.layer setValue:@-1.5707 forKeyPath:@"transform.rotation"];
            [image.layer setValue:@0 forKeyPath:@"transform.scale.y"];
                                                    } completion:^(BOOL finished){
            if (finished) {
                [self moveImageBack:image];
                [self rotateImageBack:image];
                [self updateSum:image];
            }
        }];
}

//rotate image back to original position 
-(void)rotateImageBack: (UIView*) image
{
    [UIView animateWithDuration:0.0 animations:^{
       [image.layer setValue:@0.0 forKeyPath:@"transform.rotation"];
        CGRect imageframe = CGRectMake(image.frame.origin.x, image.frame.origin.y+1, image.frame.size.width,image.frame.size.height);
        image.frame = imageframe;
                 } completion:^(BOOL finished){
        if (finished) {
            
        }
    }];
}

//moving image back to original position
-(void)moveImageBack :(UIImageView*)image
{
    image.center = self.oldCoinPosition;
    [UIView animateWithDuration:0 animations:^{
    [image.layer setValue:@-1.5707 forKeyPath:@"transform.rotation"];
    [image.layer setValue:@0.9 forKeyPath:@"transform.scale.y"];
    } completion:nil];
}

// creating a new subview of a coin image
-(void)addImageSubView: (UIImageView*) image
{
    if(image == _fiveImg || image == _tenImg || image == _twentyImg || image == _fiftyImg || image == _levImg) {
    UIView *iv = [[UIImageView alloc] initWithImage:image.image];
    CGRect imageframe = CGRectMake(image.frame.origin.x, image.frame.origin.y-7, image.frame.size.width,image.frame.size.height+15);                        //we have questions about positioning new image view
    iv.center = image.center;
    iv.frame = imageframe;
    [[image superview] addSubview:iv];
   }
}

@end
