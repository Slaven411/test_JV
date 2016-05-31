//
//  AddItemsViewController.m
//  TestProjectJelly
//
//  Created by Roma Herman on 12/16/15.
//  Copyright © 2015 Slava. All rights reserved.
//

#import "AddItemsViewController.h"
#import "AddCollectionViewController.h"


@interface AddItemsViewController ()

@end

@implementation AddItemsViewController

@synthesize addItem;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(UIBarButtonItem *)sender {
  
  [super cancelAndDesmiss];
}

- (IBAction)save:(UIBarButtonItem *)sender {
    
    addItem.name = _name.text;
    [super saveAndDesmiss];
    
}

@end
