//
//  TextModel+CoreDataProperties.h
//  TestProjectJelly
//
//  Created by Roma Herman on 12/16/15.
//  Copyright © 2015 Slava. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TextModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TextModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
