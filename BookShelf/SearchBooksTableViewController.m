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

- (void) viewDidDisappear:(BOOL)animated {
    self.searchController.active = NO;
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
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kSearchBookURLString, searchText];
    
    if (searchText && self.searchController.active) {
        __weak typeof(self) weakSelf = self;
        [BookStoreUtils getBooksWithUrlString:urlString completionBlock:^(NSArray<Book *> *books) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                strongSelf.books = [books copy];
                [strongSelf.tableView reloadData];
                
            });
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.books count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SBreuseIdentifier" forIndexPath:indexPath];
    
    Book *book = [self.books objectAtIndex:indexPath.row];
    cell.imageView.image = book.image;
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.subTitle;
    
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
