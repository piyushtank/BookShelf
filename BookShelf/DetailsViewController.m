//
//  DetailsViewController.m
//  BookShelf
//
//  Created by Bhavisha Tank on 11/17/19.
//  Copyright © 2019 PiyushTank. All rights reserved.
//

#import "DetailsViewController.h"
#import "BookStoreUtils.h"

@interface DetailsViewController ()

@property (nonatomic, strong) Book *book;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    
    [BookStoreUtils getBooksWithUrlString:@"https://api.itbook.store/1.0/books/9781449343569" completionBlock:^(NSArray<Book *> *books) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            self.book = [books objectAtIndex:0];
            
        });
    }];
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

@end
