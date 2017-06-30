//
//  Test+CoreDataProperties.h
//  sqllite3
//
//  Created by Vito on 2017/4/22.
//  Copyright © 2017年 metarnet. All rights reserved.
//

#import "Test+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Test (CoreDataProperties)

+ (NSFetchRequest<Test *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
