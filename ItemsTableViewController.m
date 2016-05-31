//
//  ItemsTableViewController.m
//  TestProjectJelly
//
//  Created by Roma Herman on 12/16/15.
//  Copyright © 2015 Slava. All rights reserved.
//

#import "ItemsTableViewController.h"
#import "AppDelegate.h"
#import "AddItemsViewController.h"


@interface ItemsTableViewController ()


@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ItemsTableViewController

- (NSManagedObjectContext*)managedObjectContext {
  
  return [(AppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
  
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  if ([[segue identifier]isEqualToString:@"addItem"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    AddItemsViewController *addItemsViewController = (AddItemsViewController*)navigationController.topViewController;
    
    TextModel *addItem = [NSEntityDescription insertNewObjectForEntityForName:@"TextModel" inManagedObjectContext:[self managedObjectContext]];
    
    addItemsViewController.addItem = addItem;
    
  }
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
   
  
  NSError *error = nil;
  if (![[self fetchedResultsController]performFetch:&error]) {
    NSLog(@"Error! %@",error);
    abort();
  
 }
}

-(void)viewWillAppear:(BOOL)animated {

  [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
  return [sectionInfo numberOfObjects];
}



- (NSFetchedResultsController*)fetchedResultsController {
  
  if (_fetchedResultsController != nil) {
    return _fetchedResultsController;
 }

  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
  
  NSManagedObjectContext *context = [self managedObjectContext];
  
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"TextModel" inManagedObjectContext:context];
 
  [fetchRequest setEntity:entity];
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
  
  NSArray *sortDescriptors = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
  fetchRequest.sortDescriptors = sortDescriptors;
  
  
  _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
  
  _fetchedResultsController.delegate = self;
  
  return _fetchedResultsController;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    TextModel *textModel = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = textModel.name;
    cell.imageView.image = [UIImage imageNamed:@"3"];
  
    return cell;
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  
  [self.tableView beginUpdates];

}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {

  [self.tableView endUpdates];
  
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(nonnull id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
  
  switch (type) {
    case NSFetchedResultsChangeInsert:
      [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      
      break;
      
  }
  
  
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {

  UITableView *tableView = self.tableView;
  
  switch (type) {
    case NSFetchedResultsChangeInsert:
      [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeUpdate:{
      TextModel *changeTextModel = [self.fetchedResultsController  objectAtIndexPath:indexPath];
      UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
      cell.textLabel.text = changeTextModel.name;
    
    }
      break;
      
    case NSFetchedResultsChangeMove:
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:
       UITableViewRowAnimationFade];
      [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
  }

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
      NSManagedObjectContext *context = [self managedObjectContext];
      
      TextModel *textModelDelete = [self.fetchedResultsController objectAtIndexPath:indexPath ];
      
      [context deleteObject:textModelDelete];
      
      NSError *error = nil;
      
      if (![context save:&error]) {
        NSLog(@"Error %@",error);
      }
    }
}






/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
