//
//  NewBooksTableViewController.m
//  BookShelf
//
//  Created by Bhavisha Tank on 11/10/19.
//  Copyright © 2019 PiyushTank. All rights reserved.
//

#import "NewBooksTableViewController.h"
#import "Book.h"

NSString *kNewBookURLString = @"https://api.itbook.store/1.0/new";

@interface NewBooksTableViewController ()

@property (nonatomic, strong) NSArray<Book *> *books;

@end

@implementation NewBooksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        __strong NewBooksTableViewController *strongSelf = weakSelf;
        NSError *error = nil;

        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:kNewBookURLString]];
        if (!error && jsonData) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:0
                                                                   error:&error];
            NSArray *booksList = dict[@"books"];
            if (!error && dict) {
                if ([dict[@"error"] isEqualToString:@"0"]) {
                    NSString *numStr = dict[@"total"];
                    NSInteger total = atoi([numStr UTF8String]);
                    NSAssert(total == [booksList count], @"total doesn't match the retrieved books");
                    
                    Book *book = nil;
                    NSMutableArray *books = [NSMutableArray array];
                    
                    for (NSDictionary *bookDict in booksList) {
                        book = [[Book alloc] initWithTitle:bookDict[@"title"]
                                                  subTitle:bookDict[@"subtitle"]
                                                    isbn13:bookDict[@"isbn13"]
                                                     price:bookDict[@"isbn13"]
                                                  imageUrl:bookDict[@"image"]
                                                       url:bookDict[@"url"]];
                        [books addObject:book];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        strongSelf.books = [books copy];
                        [strongSelf.tableView reloadData];
                    });
                } else {
                    NSLog(@"Error returned by server retriving books");
                }
                
            } else {
                NSLog(@"Error - json serialization, error = %@", error);
            }
        } else {
            NSLog(@"Error - retriving json data, error = %@", error);
        }
    });
    
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
