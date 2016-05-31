//
//  AddItemsViewController.h
//  TestProjectJelly
//
//  Created by Roma Herman on 12/16/15.
//  Copyright © 2015 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreViewController.h"
#import "TextModel+CoreDataProperties.h"


@interface AddItemsViewController : CoreViewController

@property (nonatomic, strong) TextModel *addItem;

@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UITextField *name;






- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)save:(UIBarButtonItem *)sender;


@end
