//
//  AddCollectionViewController.m
//  TestProjectJelly
//
//  Created by Slava on 27.04.16.
//  Copyright © 2016 Slava. All rights reserved.
//

#import "AddCollectionViewController.h"
#import "AddCollectionViewCell.h"
#import "ItemsTableViewController.h"
#import "AppDelegate.h"
#import "AddItemsViewController.h"

@interface AddCollectionViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSArray *images;
@end

@implementation AddCollectionViewController


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
    
    self.images = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4" , nil];

    NSError *error = nil;
    if (![[self fetchedResultsController]performFetch:&error]) {
        NSLog(@"Error! %@",error);
        abort();
        
    }
    
    UILongPressGestureRecognizer *lpgr
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.delegate = self;
    lpgr.delaysTouchesBegan = YES;
    [self.collectionView addGestureRecognizer:lpgr];
    

}



-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    TextModel *textModelDelete = [self.fetchedResultsController objectAtIndexPath:indexPath ];
    

    [context deleteObject:textModelDelete];
    //[self.images removeObjectAtIndex:indexPath.row];
    //[self.collectionView setContentOffset:CGPointZero animated:NO];
    //[self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
   //AddCollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
  
   
  
    NSError *error = nil;
    
    if (![context save:&error]) {
        NSLog(@"Error %@",error);
           }
    
    
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else {
        // get the cell at indexPath (the one you long pressed)
        NSLog(@"long Press");
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[self.fetchedResultsController sections]count];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
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


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.collectionView reloadData];

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    TextModel *textModel = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"4"];
    cell.textLabel.text = textModel.name;

    return cell;
    
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{


    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.collectionView insertSections:[NSMutableIndexSet indexSetWithIndex:sectionIndex]];
            break;
            
        default:
            break;
    }

}

    
    
    
    

#pragma mark <UICollectionViewDelegate>
/*

// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
