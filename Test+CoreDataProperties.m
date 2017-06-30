//
//  Test+CoreDataProperties.m
//  sqllite3
//
//  Created by Vito on 2017/4/22.
//  Copyright © 2017年 metarnet. All rights reserved.
//

#import "Test+CoreDataProperties.h"

@implementation Test (CoreDataProperties)

+ (NSFetchRequest<Test *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Test"];
}

@dynamic name;

@end
