//
//  CoreViewController.m
//  TestProjectJelly
//
//  Created by Roma Herman on 12/16/15.
//  Copyright © 2015 Slava. All rights reserved.
//

#import "CoreViewController.h"
#import "AppDelegate.h"
#import "AddCollectionViewController.h"
#include "AddCollectionViewCell.h"

@interface CoreViewController ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation CoreViewController

- (NSManagedObjectContext*)managedObjectContext {
  
  return [(AppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];

}
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

-(void)cancelAndDesmiss {
    
    [self.managedObjectContext rollback];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveAndDesmiss {
    
    NSError *error = nil;
    if ([self.managedObjectContext hasChanges]) {
        if (![self.managedObjectContext save:&error]) {//save failed
            NSLog(@"Save Failed: %@",[error localizedDescription]);
        } else {
            NSLog(@"Save done");
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


@end
