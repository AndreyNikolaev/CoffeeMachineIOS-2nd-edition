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
@synthesize footerView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"admCoffee.jpg"]];

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
    UIImageView *av = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 277, 58)];
    av.backgroundColor = [UIColor clearColor];
    av.opaque = NO;
    av.image = [UIImage imageNamed:@"coffee-back.png"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell" ];
    }
        if(indexPath.section == 0) {
            NSUInteger count = [self.drinksSold count];
            for (NSUInteger i = 0; i < count; i++) {
                if(indexPath.row==i){
            
                    NSString *current = [self.drinksSold objectAtIndex: i];
                    cell.textLabel.text=current;
                    cell.backgroundView = av;
                    
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                    imgView.image = [UIImage imageNamed:@"kafe-1.png"];
                    cell.imageView.image = imgView.image;

                }
            }return cell;
        }else{
            NSUInteger count = [_moneyAmount count];
            for (NSUInteger i = 0; i < count; i++) {
                if(indexPath.row==i){
                    
                    NSString *current = [_moneyAmount objectAtIndex: i];
                    cell.textLabel.text=current;
                    cell.backgroundView = av;
                    
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                    imgView.image = [UIImage imageNamed:@"emptyCoin.png"];
                    cell.imageView.image = imgView.image;

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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if(footerView == nil) {
        footerView  = [[UIView alloc] init];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setFrame:CGRectMake(5, 3, 300, 44)];
        [button setTitle:@"Click" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [button addTarget:self action:@selector(loadPlistFromURL:)
         forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:button];
    }
    return footerView;
}
-(IBAction)loadPlistFromURL:(id)sender {
    
}
@end
