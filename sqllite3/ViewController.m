//
//  ViewController.m
//  sqllite3
//
//  Created by 张建学 on 16/9/16.
//  Copyright © 2016年 metarnet. All rights reserved.
//

#import <sqlite3.h>
#import "ViewController.h"

@interface ViewController ()

@end

static sqlite3 * db = nil;
@implementation ViewController

//添加注释

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString * fileName = [[NSSearchPathForDirectoriesInDomains(13, 1, 1)lastObject]stringByAppendingPathComponent:@"text1.sqlite"];
    NSLog(@"%@",fileName);
    if (sqlite3_open(fileName.UTF8String, &db) == SQLITE_OK) {
        NSLog(@"打开数据库成功");
        
        //打开数据库成功后建立数据库内的表
        //操作命令的字符串
        //注意字符串的结束处有 ; 号
        NSString * sql = @"create table if not exists t_text (id integer primary key autoincrement,name text,age integr);";
        char * errmsg;
        
        sqlite3_exec(db, sql.UTF8String, NULL, NULL, &errmsg);
        if (errmsg) {
            NSLog(@"建表失败 -- %s",errmsg);
        }else{
            NSLog(@"建表成功");
        }
    }else{
        
        NSLog(@"打开数据库失败");
    }
    
}
- (IBAction)inset:(id)sender {
    
    //这里删除随机id 大于3 小于6的
    //操作代码(sql)
    //最好先判断能否进入数据库在执行操作 这里偷下懒
    NSString * sql = @"delete from t_text where id > 3 and id < 9;";
    char * errmsg;
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, &errmsg);
    if (errmsg) {
        NSLog(@"删除失败--%s",errmsg);
    }else{
        NSLog(@"删除成功");
    }
    
}
- (IBAction)update:(id)sender {
    
    //这里吧id为9的 name更改为 hello-world
    //操作代码(sql)
    //最好先判断能否进入数据库在执行操作 这里偷下懒
    NSString * sql = @"update t_text set name = 'hello-world' where id = 9;";
    char * errmsg;
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, &errmsg);
    if (errmsg) {
        NSLog(@"修改失败--%s",errmsg);
    }else{
        NSLog(@"修改成功");
    }
}

- (IBAction)query:(id)sender {
    
    //查询所有信息
    //操作代码(sql)
    //最好先判断能否进入数据库在执行操作 这里偷下懒
    NSString * sql = @"select * from t_text;";
    
    //查询的句柄,游标
    sqlite3_stmt * stmt;
    
    if (sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        
        //查询数据
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            //获取表数据的内容
            //sqlite3_column_text('句柄'，字段索引值)
            
            NSString * name = [NSString stringWithCString:(const char *)sqlite3_column_text(stmt, 1) encoding:NSUTF8StringEncoding];
            
            NSLog(@"name = %@",name);
            
        }
    }

}

- (IBAction)add:(id)sender {
    
    for (NSInteger i = 0; i < 10; i ++) {
        //最好先判断能否进入数据库在执行操作 这里偷下懒
        NSString * sql = [NSString stringWithFormat:@"insert into t_text(name) values('%@');",[NSString stringWithFormat:@"旭宝爱吃鱼--%zd",arc4random_uniform(99) ]];
        
        char * errmsg;
        sqlite3_exec(db, sql.UTF8String, NULL, NULL, &errmsg);
        if (errmsg) {
            NSLog(@"插入失败--%s",errmsg);
        }else{
            NSLog(@"插入成功");
        }
    }

}

@end
