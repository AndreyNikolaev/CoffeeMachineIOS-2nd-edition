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
@interface PaymentFlow ()

@end

@implementation PaymentFlow

@synthesize coffeeMachineState;
@synthesize selectedDrink;
@synthesize userCoins;

@synthesize oldCoinPosition;

@synthesize sumLbl;

@synthesize fiveImg;
@synthesize tenImg;
@synthesize twentyImg;
@synthesize fiftyImg;
@synthesize levImg;
@synthesize slotImg;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    sum = 0;
    userCoins=[[MoneyAmount alloc]init];
   
   }
    
-(void) moveCoin: (UIImageView*) image
{   
    self.oldCoinPosition = image.center;
    [self addImageSubView:image];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panGesture setDelegate:self];
    /* set no of touch for pan gesture*/
    
   [ panGesture setMaximumNumberOfTouches:1];
    [image addGestureRecognizer:panGesture];
    
}


-(BOOL)didCoinImageIsInSlotImg: (UIImageView*)coinImage: (UIImageView*)slotImage
{
    BOOL flag = YES;
    if(coinImage.center.x < slotImg.center.x - 20) flag = false;
    if(coinImage.center.x > slotImg.center.x + 20) flag = false;
    return flag;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchBack:(id)sender {
    ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewController"bundle:nil ];
    [[self navigationController ]setNavigationBarHidden:NO animated:YES];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)setCoinInUserCoins:(int)coinValue
{
    Coin *userCoin=[[Coin alloc]init];
    userCoin.value=coinValue;
    [self.userCoins addCoin:userCoin amount:1];
    sumLbl.text=[NSString stringWithFormat:@"%d",[self.userCoins sumOfCoins]];
}

- (void) switchMenu {  
    if( userCoins.sumOfCoins >= selectedDrink.price){
        int test = [userCoins sumOfCoins] - selectedDrink.price;
        Withdraw* withdraw = [[Withdraw alloc]init];
        withdraw = [coffeeMachineState.coins withdraw:test];
        if(withdraw.status== SUCCESSFUL){
            
            OrderFinalizeFlow *orderFinalizeFlow =[ [OrderFinalizeFlow alloc]initWithNibName:@"OrderFinalizeFlow" bundle:nil];
            orderFinalizeFlow.coffeeMachineState = self.coffeeMachineState;
            orderFinalizeFlow.selectedDrink = self.selectedDrink;
            orderFinalizeFlow.change = withdraw.change;
            orderFinalizeFlow.userCoins = self.userCoins;
            orderFinalizeFlow.willGetDrink = YES;
            
            [UIView  beginAnimations:nil context:NULL];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.75];
            [self.navigationController pushViewController:orderFinalizeFlow animated:NO];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
            [UIView commitAnimations];

            //[self.navigationController pushViewController:orderFinalizeFlow animated:YES];
        }
        else{
            InsufficientAmountFlow *insAmountFlow=[[InsufficientAmountFlow alloc]initWithNibName:@"InsufficientAmountFlow" bundle:nil];
            insAmountFlow.coffeeMachineState = self.coffeeMachineState;
            insAmountFlow.selectedDrink = self.selectedDrink;
            insAmountFlow.change = withdraw.change;
            insAmountFlow.userCoins = self.userCoins;
            [UIView  beginAnimations:nil context:NULL];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.75];
            [self.navigationController pushViewController:insAmountFlow animated:NO];
      
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
            [UIView commitAnimations];

            //[self presentViewController:insAmountFlow animated:YES completion:nil];
           // [self.navigationController pushViewController: insAmountFlow animated:YES];
        }
        
      
    }
}


-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {

    

    if([recognizer state] == UIGestureRecognizerStateBegan){
        [self moveCoin:recognizer.view];
        [self.view bringSubviewToFront:recognizer.view];
    }

    if(recognizer.view == fiveImg || recognizer.view == tenImg || recognizer.view == twentyImg || recognizer.view == fiftyImg || recognizer.view == levImg) {
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    recognizer.view.center=CGPointMake(recognizer.view.center.x+translation.x, recognizer.view.center.y+ translation.y);
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view];
    if([recognizer state] == UIGestureRecognizerStateEnded){
        
        if([self didCoinImageIsInSlotImg:recognizer.view :slotImg]){ // when the coin is near the slot
            recognizer.view.center = CGPointMake(slotImg.center.x,slotImg.center.y);
            [self rotateImage:recognizer.view];
            [self updateSum:recognizer.view];
        

            
        }
        else  recognizer.view.center = oldCoinPosition;
    }
    
                                  }
}


-(void)updateSum: (UIImageView*) image {
    
    if (image == fiveImg){
        
        
        [self setCoinInUserCoins:5];
        [self switchMenu];
      //  [self rotateImage:fiveImg];
        
        
        
        
        
    }
    if (image == tenImg)
    {
        [self setCoinInUserCoins:10];
        [self switchMenu];
        //[self rotateImage:tenImg];
        
    }
    if (image == twentyImg)
    {
        [self setCoinInUserCoins:20];
        [self switchMenu];
       // [self rotateImage:twentyImg];
        
    }
    if (image == fiftyImg)
    {
        [self setCoinInUserCoins:50];
        [self switchMenu];
      //  [self rotateImage:fiftyImg];
        
    }
    if (image== levImg)
    {
        [self setCoinInUserCoins:100];
        [self switchMenu];
       // [self rotateImage:levImg];
        
    }

}



-(void)rotateImage: (UIImageView*) image 
{
<<<<<<< HEAD

        [UIView animateWithDuration:3.0 animations:^{
=======
        [UIView animateWithDuration:2.0 animations:^{
>>>>>>> 2d777162011538e2d82ee47bdbd192dff8ccb749
    
            [image.layer setValue:@-1.5707 forKeyPath:@"transform.rotation"];
            [image.layer setValue:@0 forKeyPath:@"transform.scale.y"];
                                                    } completion:^(BOOL finished){
            if (finished) {
                [self moveImageBack:image];
                [self rotateImageBack:image];
            }
        }];
<<<<<<< HEAD
    
          }
=======
}
-(void)rotateImageBack: (UIImageView*) image
{
    [UIView animateWithDuration:0.0 animations:^{
        
        [image.layer setValue:@0.0 forKeyPath:@"transform.rotation"];
                 } completion:^(BOOL finished){
        if (finished) {
            
        }
    }];
}

>>>>>>> 2d777162011538e2d82ee47bdbd192dff8ccb749

-(void)moveImageBack :(UIImageView*)image {
    NSLog(@"test");
    image.center = self.oldCoinPosition;
    [UIView animateWithDuration:0 animations:^{
        
    [image.layer setValue:@-1.5707 forKeyPath:@"transform.rotation"];
    [image.layer setValue:@0.9 forKeyPath:@"transform.scale.y"];
    } completion:nil];
}
-(void)addImageSubView: (UIImageView*) image {
    if(image == fiveImg || image == tenImg || image == twentyImg || image == fiftyImg || image == levImg) {
    UIView *iv = [[UIImageView alloc] initWithImage:image.image];
    CGRect imageframe = CGRectMake(image.frame.origin.x, image.frame.origin.y-7, image.frame.size.width,image.frame.size.height+15);
    iv.center = image.center;
    iv.frame = imageframe;
    [[image superview] addSubview:iv];
   }
}
@end
