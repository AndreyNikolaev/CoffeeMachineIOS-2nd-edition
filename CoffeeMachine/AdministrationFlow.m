//
//  AdministrationFlow.m
//  CoffeeMachine
//
//  Created by dancho on 8/27/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "AdministrationFlow.h"
#import "ViewController.h"
#import "Theme.h"

#define PLIST_URL       @"https://raw.github.com/AndreyNikolaev/CoffeeMachineIOS/master/CoffeeMachine/sourceFile.plist"
#define PLIST_FILENAME  @"writedFile.plist"

@interface AdministrationFlow ()

@end

@implementation AdministrationFlow

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self formatView];
    _moneyAmount = [[NSMutableArray alloc] initWithArray:self.coffeeMachineState.coins.coinsAmountToString];
    self.drinksStringArray = [[NSMutableArray alloc] initWithArray:self.coffeeMachineState.currentDrinksAmount.drinkNameAndQuantity];
    
}

-(void)formatView
{
    Theme *theme = [Theme sharedTheme];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[theme backGroudImage]];
    self.tableView.contentMode = UIViewContentModeScaleAspectFill;
    self.title = @"Reports";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Load from URL" style:UIBarButtonItemStyleBordered target:self action:@selector(loadPlistFromURL:)];
    self.navigationItem.rightBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView :(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return _drinksStringArray.count;
    }else{
        return _moneyAmount.count;
    }
}

- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableIndexPath = indexPath;
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell" ];
    }
    UIImageView *av = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 277, 58)];
    av.backgroundColor = [UIColor clearColor];
    av.opaque = NO;
    av.image = [UIImage imageNamed:@"coffee-back.png"];
    if(indexPath.section == 0) {
        NSUInteger count = [self.drinksStringArray count];
        for (NSUInteger i = 0; i < count; i++) {
            if(indexPath.row==i){
                NSString *current = [self.drinksStringArray objectAtIndex: i];
                cell.textLabel.text=current;
                cell.backgroundView = av;
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                imgView.image = [UIImage imageNamed:@"kafe-1.png"];
                cell.imageView.image = imgView.image;
            }
        } return cell;
    } else {
        NSUInteger count = [_moneyAmount count];
        for (NSUInteger i = 0; i < count; i++) {
            if(indexPath.row == i){
                NSString *current = [_moneyAmount objectAtIndex: i];
                cell.textLabel.text=current;
                cell.backgroundView = av;
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                imgView.image = [UIImage imageNamed:@"emptyCoin.png"];
                cell.imageView.image = imgView.image;
            }
        } return cell;
    }
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

-(IBAction)loadPlistFromURL:(id)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:PLIST_FILENAME];
    [[NSData dataWithContentsOfURL:[NSURL URLWithString:PLIST_URL]] writeToFile:path atomically:YES];
    [self.coffeeMachineState.currentDrinksAmount loadDrinksFromPlist];
    [self.coffeeMachineState.coins loadCoinsFromPlist];
    MoneyAmount *mAmount = [[MoneyAmount alloc]init];
    mAmount = self.coffeeMachineState.coins;
    _moneyAmount = [[NSMutableArray alloc]initWithArray:mAmount.coinsAmountToString];
    DrinksContainer *soldDrinks =[[ DrinksContainer alloc]init ];
    soldDrinks = self.coffeeMachineState.currentDrinksAmount;
    self.drinksStringArray = [[NSMutableArray alloc]initWithArray:soldDrinks.drinkNameAndQuantity];
    [self.tableView reloadData];
}

@end
