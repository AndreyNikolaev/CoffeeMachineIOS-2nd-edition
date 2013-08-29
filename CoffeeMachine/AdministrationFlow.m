//
//  AdministrationFlow.m
//  CoffeeMachine
//
//  Created by dancho on 8/27/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "AdministrationFlow.h"
#import "ViewController.h"

@interface AdministrationFlow ()
@end
@implementation AdministrationFlow


@synthesize tableView = _tableView;
@synthesize moneyAmount = _moneyAmount;
@synthesize drinksSold;
@synthesize coffeeMachineState;



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Administrator report";
    DrinksContainer *soldDrinks =[[ DrinksContainer alloc]init ];
    soldDrinks=self.coffeeMachineState.currentDrinksAmount;
    //[soldDrinks setSomeDrinks];
    MoneyAmount *mAmount = [[MoneyAmount alloc]init];
    mAmount=self.coffeeMachineState.coins;
    //[mAmount setSomeCoins];

   _moneyAmount = [[NSMutableArray alloc]initWithArray:mAmount.coinsAmountToString];
    self.drinksSold = [[NSMutableArray alloc]initWithArray:soldDrinks.drinkNameAndQuantityToString];
}


- (void)didReceiveMemoryWarning
{
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView :(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return drinksSold.count;
    }else{
        return _moneyAmount.count;
    }
}

- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell" ];
    }
        if(indexPath.section == 0) {
            NSUInteger count = [self.drinksSold count];
            for (NSUInteger i = 0; i < count; i++) {
                if(indexPath.row==i){
            
                    NSString *current = [self.drinksSold objectAtIndex: i];
                    cell.textLabel.text=current;
                }
            }return cell;
        }else{
            NSUInteger count = [_moneyAmount count];
            for (NSUInteger i = 0; i < count; i++) {
                if(indexPath.row==i){
                    
                    NSString *current = [_moneyAmount objectAtIndex: i];
                    cell.textLabel.text=current;
                }

        }return cell;

        }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
            
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"Drinks";
    }else{
        return @"Coins";
    }
}
@end
