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

@property(strong) NSMutableArray *drinksSold;
@property(strong) NSMutableArray *moneyAmount;
@property CoffeeMachineState* coffeeMachineState;
@property NSIndexPath* tableIndexPath;



- (IBAction)loadPlistFromURL:(id)sender;
<<<<<<< HEAD
- (void) refreshTableView;
=======

>>>>>>> 42fb56117cae612475a1bbe58bc61e40ad5afba5
@end
