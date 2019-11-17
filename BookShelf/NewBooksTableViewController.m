//
//  NewBooksTableViewController.m
//  BookShelf
//
//  Created by Piyush Tank on 11/10/19.
//  Copyright © 2019 PiyushTank. All rights reserved.
//

#import "NewBooksTableViewController.h"

#import "Book.h"
#import "BookStoreUtils.h"
#import "DetailsViewController.h"

@interface NewBooksTableViewController ()

@property (nonatomic, strong) NSArray<Book *> *books;

@end

@implementation NewBooksTableViewController

static NSString * const kNewBookURLString = @"https://api.itbook.store/1.0/new";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    [BookStoreUtils getBooksWithUrlString:kNewBookURLString completionBlock:^(NSArray<Book *> *books) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.books = [books copy];
            [strongSelf.tableView reloadData];
            
        });
    }];
    
    self.navigationItem.title = @"New Books";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.books count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NBreuseIdentifier" forIndexPath:indexPath];
    
    Book *book = [self.books objectAtIndex:indexPath.row];
    cell.imageView.image = book.image;
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.subTitle;
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"NewBooksToDetails"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        Book *book = [self.books objectAtIndex:path.row];
        DetailsViewController *vc = [segue destinationViewController];
        vc.isbn13 = book.isbn13;
    }
}

@end
