//
//  SearchBooksTableViewController.m
//  BookShelf
//
//  Created by Piyush Tank on 11/10/19.
//  Copyright © 2019 PiyushTank. All rights reserved.
//

#import "SearchBooksTableViewController.h"

#import "Book.h"
#import "BookStoreUtils.h"
#import "DetailsViewController.h"

@interface SearchBooksTableViewController ()

@property (nonatomic, strong) NSMutableArray<Book *> *books;
@property (strong, nonatomic) UISearchController *searchController;
@property (assign, nonatomic) NSInteger total;
@property (strong, nonatomic) NSString *theUrlString;

@end

@implementation SearchBooksTableViewController

static NSString * const kSearchBookURLString = @"https://api.itbook.store/1.0/search/";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Search";
    [self setupSearchController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.searchController) {
        self.definesPresentationContext = YES;
    } else {
        [self setupSearchController];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.definesPresentationContext = NO;
    [super viewWillDisappear:animated];
}

- (void)setupSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchText = searchController.searchBar.text;
    self.theUrlString = [NSString stringWithFormat:@"%@%@", kSearchBookURLString, searchText];
    
    if (searchText && self.searchController.active) {
        self.books = nil;
        __weak typeof(self) weakSelf = self;
        [BookStoreUtils getBooksWithUrlString:self.theUrlString completionBlock:^(NSArray<Book *> *books,
                                                                             NSInteger total,
                                                                             NSString *urlString) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([urlString isEqualToString:weakSelf.theUrlString]) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    strongSelf.books = [NSMutableArray arrayWithArray:books];
                    self.total = total;
                    [strongSelf.tableView reloadData];
                    NSInteger remaining = self.total - [books count];
                    if (remaining > 0) {
                        NSInteger pageIndex = 2;
                        NSString *pageUrlString = [NSString stringWithFormat:@"%@/%ld", urlString, (long)pageIndex];
                        [strongSelf fetchBooks:pageUrlString pageIndex:2];
                    }
                }
            });
        }];
    }
}

- (void)fetchBooks:(NSString *)pageUrlString pageIndex:(NSInteger)pageIndex {
    if ([pageUrlString rangeOfString:self.theUrlString].location == NSNotFound) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [BookStoreUtils getBooksWithUrlString:pageUrlString completionBlock:^(NSArray<Book *> *books,
                                                                          NSInteger total,
                                                                          NSString *pageUrlString) {
        NSLog (@"pageUrlString = %@", pageUrlString);
        if ([pageUrlString rangeOfString:self.theUrlString].location != NSNotFound) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if ([pageUrlString rangeOfString:self.theUrlString].location != NSNotFound) {
                    NSUInteger booksCount = [strongSelf.books count];
                    if (booksCount && booksCount < total) {
                        if (strongSelf.books) {
                            [strongSelf.books addObjectsFromArray:books];
                        }
                        
                        NSUInteger remaining = (total - booksCount) < 10 ? (total - booksCount) : 10;
                        NSMutableArray<NSIndexPath *> *indexPathArray = [NSMutableArray array];
                        for (NSUInteger index = booksCount; index < booksCount + remaining; index++) {
                            [indexPathArray addObject:[NSIndexPath  indexPathForRow:index inSection:0]];
                        }
                        [strongSelf.tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
                        
                        NSInteger thePageIndex = pageIndex;
                        NSString *thePageUrlString = [NSString stringWithFormat:@"%@/%ld", strongSelf.theUrlString, (long)pageIndex];
                        [strongSelf fetchBooks:thePageUrlString pageIndex:++thePageIndex];
                    }
                }
            });
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.total;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SBreuseIdentifier" forIndexPath:indexPath];
    
    if ([self.books count] > indexPath.row) {
        Book *book = [self.books objectAtIndex:indexPath.row];
        cell.imageView.image = book.image;
        cell.textLabel.text = book.title;
        cell.detailTextLabel.text = book.subTitle;
        cell.userInteractionEnabled = YES;
    } else {
        cell.imageView.image = nil;
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SearchBooksToDetails"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        Book *book = [self.books objectAtIndex:path.row];
        DetailsViewController *vc = [segue destinationViewController];
        vc.isbn13 = book.isbn13;
    }
}

@end
