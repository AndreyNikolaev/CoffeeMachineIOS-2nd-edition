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


@synthesize sumLbl;

@synthesize fiveImg;
@synthesize tenImg;
@synthesize twentyImg;
@synthesize fiftyImg;
@synthesize levImg;


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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
   UITouch *touch = [touches anyObject];
    // drag should only occur if the object is a coin
  [self moveCoin:touch.view];
   [self.view bringSubviewToFront:[touch view]];
     
}

-(void) moveCoin: (UIImageView*) image
{

       
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panGesture setDelegate:self];
    /* set no of touch for pan gesture*/
    
    [panGesture setMaximumNumberOfTouches:1];
    
    /*  Add gesture to your imagehytdty. */
    
    [image addGestureRecognizer:panGesture];

    

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
    
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    recognizer.view.center=CGPointMake(recognizer.view.center.x+translation.x, recognizer.view.center.y+ translation.y);
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view];
    
       
}
-(void)handle:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    recognizer.view.center=CGPointMake(recognizer.view.center.x+translation.x, recognizer.view.center.y+ translation.y);
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view];
    
}




//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /*UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    if([touch view] == fiveImg || [touch view] == tenImg || [touch view] == twentyImg || [touch view] == fiftyImg || [touch view] == levImg)
    {
        [touch view].center = location;
    }
    
    */
    
    //coment for testig draging coins images
  /*  if ([touch view] == fiveImg){

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];

  /*
    if ([touch view] == fiveImg){


        [self setCoinInUserCoins:5];
        [self switchMenu];
        [self rotateImage:fiveImg];
        

    }
    if ([touch view] == tenImg)
    {
        [self setCoinInUserCoins:10];
        [self switchMenu];
        [self rotateImage:tenImg];
        
    }
    if ([touch view] == twentyImg)
    {
        [self setCoinInUserCoins:20];
        [self switchMenu];
        [self rotateImage:twentyImg];
        
    }
    if ([touch view] == fiftyImg)
    {
        [self setCoinInUserCoins:50];
        [self switchMenu];
        [self rotateImage:fiftyImg];
        
    }
    if ([touch view] == levImg)
    {
        [self setCoinInUserCoins:100];
        [self switchMenu];
        [self rotateImage:levImg];
        
    }
<<<<<<< HEAD
    
}
   */
/*-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
=======
   */
    
//}

/*
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    

>>>>>>> f78579b100e482153182f7187e0eb525c1337521
    //[self touchesBegan:touches withEvent:event];
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint touchLocation = [touch locationInView:self.view];
    
    if ([touch view] == fiveImg || [touch view] == tenImg || [touch view] == twentyImg || [touch view] == fiftyImg || [touch view] == levImg)
 {
        
        //fiftyImg.center = touchLocation;
     [touch view].center = touchLocation;
     [self.view bringSubviewToFront:[touch view]];
     
        
    }
    
            

    

}
 
 */


-(void)rotateImage: (UIImageView*) image
{
    
    [UIView animateWithDuration:1.0 animations:^{
       
    
        image.layer.transform = CATransform3DMakeRotation(M_PI,1.0,1.0,1.0);
    } completion:nil];
    [UIView animateWithDuration:1.0 animations:^{
        image.layer.transform = CATransform3DMakeRotation(M_PI,0.0,0.0,0.0);
    } completion:nil];

}



@end