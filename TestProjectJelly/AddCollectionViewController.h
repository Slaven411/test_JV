//
//  AddCollectionViewController.h
//  TestProjectJelly
//
//  Created by Slava on 27.04.16.
//  Copyright © 2016 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextModel.h"

@interface AddCollectionViewController : UICollectionViewController<NSFetchedResultsControllerDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) TextModel* textModel;
//@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;


@end
