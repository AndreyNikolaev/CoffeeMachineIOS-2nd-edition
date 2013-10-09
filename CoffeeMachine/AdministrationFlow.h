//
//  AdministrationFlow.h
//  CoffeeMachine
//
//  Created by dancho on 8/27/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CoffeeMachineState;

@interface AdministrationFlow : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong) NSMutableArray *drinksStringArray;
@property(strong) NSMutableArray *moneyAmount;
@property CoffeeMachineState* coffeeMachineState;
@property NSIndexPath* tableIndexPath;

- (IBAction)loadPlistFromURL:(id)sender;
-(void)formatView;
@end
