//
//  ItemsTableViewController.h
//  TestProjectJelly
//
//  Created by Roma Herman on 12/16/15.
//  Copyright © 2015 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextModel.h"



@interface ItemsTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) TextModel* textModel;





@end
