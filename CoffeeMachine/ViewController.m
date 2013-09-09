//
//  ViewController.m
//  PickerViewTest
//
//  Created by dancho on 8/6/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "ViewController.h"
#import "PaymentFlow.h"
#import "Drink.h"
#import "DrinksContainer.h"
#import "CoffeeMachineState.h"
#import "MoneyAmount.h"
#import "AdministrationFlow.h"


@interface ViewController ()

@end



@implementation ViewController

@synthesize itemsArray = _itemsArray;
@synthesize tableView = _tableView;
@synthesize coffeeMachineState=_coffeeMachineState;
@synthesize alertView=_alertView;

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.title = @"Coffee Machine";
    UIBarButtonItem *adminButton = [[UIBarButtonItem alloc] initWithTitle:@"Admin" style:UIBarButtonItemStyleBordered target:self action:@selector(goToAdministrationFlow:)];
    self.navigationItem.rightBarButtonItem = adminButton;
    
    DrinksContainer *drinks =[[ DrinksContainer alloc]init ];
    [drinks loadDrinksFromPlist];


    
        //[drinks setSomeDrinks];
   // [drinks loadDrinksFromPlist];
    //[drinks saveDrinksToPlist];
    //[drinks load];
   


    MoneyAmount *moneyAmount = [[MoneyAmount alloc]init];
    [moneyAmount loadCoinsFromPlist];
    
    if (self.coffeeMachineState == nil) {
        self.coffeeMachineState=[[CoffeeMachineState alloc]init];
        [self.coffeeMachineState setCurrentDrinksAmount:drinks];
        self.coffeeMachineState.coins = moneyAmount;
    }
    _itemsArray=[[NSMutableArray alloc]initWithArray:[[_coffeeMachineState getCurrentDrinks] getStringDrinks]];



    

 
     //[drinks save:self.coffeeMachineState.currentDrinksAmount];
 //[self.coffeeMachineState saveStateToFile];
     
   	


 
     //[drinks save:self.coffeeMachineState.currentDrinksAmount];
 [self.coffeeMachineState saveStateToFile];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark === UITableView data source & delegate ===

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _itemsArray.count;
}
- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell" ];
    }
        
    NSUInteger count = [_itemsArray count];
    for (NSUInteger i = 0; i < count; i++) {
        if(indexPath.row==i){
            
            NSString *current = [_itemsArray objectAtIndex: i];
            cell.textLabel.text=current;
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            imgView.image = [UIImage imageNamed:@"coffee.jpg"];
            cell.imageView.image = imgView.image;
          }
    }



    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    DrinksContainer* tempDrinkContainer=[[DrinksContainer alloc]init];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PaymentFlow *paymentFlow = [[PaymentFlow alloc] init];
    paymentFlow.coffeeMachineState=_coffeeMachineState;


    paymentFlow.title = _itemsArray[indexPath.row];

   
    

    paymentFlow.title = _itemsArray[indexPath.row];
    tempDrinkContainer=_coffeeMachineState.currentDrinksAmount;
    NSArray* tempDrinksArray=[[NSArray alloc]initWithArray:[tempDrinkContainer getDrinks]];
    paymentFlow.selectedDrink=[tempDrinksArray objectAtIndex:indexPath.row];


    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:paymentFlow animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
   // [self.navigationController pushViewController:paymentFlow animated:YES];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    
}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *password = @"pass";
    if(alert.tag == 9998 && buttonIndex == 1) {
        NSString *e_pass = [[alert textFieldAtIndex:0]text ];

        if([e_pass isEqual:password]) {
            AdministrationFlow *admin = [[AdministrationFlow alloc]init];
            admin.coffeeMachineState=self.coffeeMachineState;
            [self.navigationController pushViewController:admin animated:YES];
            NSLog(@"%@", e_pass);
            
        }else{
            UIAlertView *wrongPassword = [[UIAlertView alloc] initWithTitle:@"Wrong Password" message:@"Try again"
                                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            wrongPassword.tag = 9999;
            [wrongPassword show];
                      
        }
    }else if (alert.tag == 9999) {
    
        [self goToAdministrationFlow:nil];

    }
    
}
-(void)validateUsernameAndPassword {
   
}
 

-(IBAction)goToAdministrationFlow:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Login"message:nil delegate:self cancelButtonTitle: @"Cancel"otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    alertView.tag = 9998;
    [alertView show];
}
- (void) viewDidUnload{
    [self.coffeeMachineState saveStateToFile];
    NSLog(@"application enter background");
}


@end
