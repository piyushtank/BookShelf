//
//  BookStoreUtils.m
//  BookShelf
//
//  Created by Bhavisha Tank on 11/16/19.
//  Copyright © 2019 PiyushTank. All rights reserved.
//

#import "BookStoreUtils.h"
#import "Book.h"

@implementation BookStoreUtils

+ (void)getBooksWithUrlString:(NSString *)urlString
              completionBlock:(void (^) (NSArray<Book *> *books))completionBlock {
    NSAssert([urlString length] > 0, @"urlString passed to getBooksWithUrlString is empty or nil");
    NSAssert(completionBlock, @"completionBlock passed to getBooksWithUrlString is nil");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSError *error = nil;
        NSMutableArray *books = [NSMutableArray array];
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        if (!error && jsonData) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:0
                                                                   error:&error];
            NSArray *booksList = dict[@"books"];
            if (!error && dict) {
                if ([dict[@"error"] isEqualToString:@"0"]) {
                    
                    // TODO: Use dict[@"total"] and display it on screen

                    Book *book = nil;
                    for (NSDictionary *bookDict in booksList) {
                        book = [Book bookWithBuilder:^(BookBuilder *builder) {
                            builder.title = bookDict[@"title"];
                            builder.title = bookDict[@"title"];
                            builder.subTitle = bookDict[@"subtitle"];
                            builder.isbn13 = bookDict[@"isbn13"];
                            builder.isbn13 = bookDict[@"isbn13"];
                            builder.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                                    [NSURL URLWithString:bookDict[@"image"]]]];
                            builder.url = bookDict[@"url"];
                        }];
                        [books addObject:book];
                    }
                } else {
                    NSLog(@"Error returned by server retriving books, error = %@", dict[@"error"]);
                }
            } else {
                NSLog(@"Error - json serialization, error = %@", error);
            }
        } else {
            NSLog(@"Error - retriving json data, error = %@", error);
        }
        completionBlock([books copy]);
    });
}


+ (void)getBookDetailsWithUrlString:(NSString *)urlString
                    completionBlock:(void (^) (Book *books))completionBlock {
    NSAssert([urlString length] > 0, @"urlString passed to getBooksWithUrlString is empty or nil");
    NSAssert(completionBlock, @"completionBlock passed to getBooksWithUrlString is nil");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSError *error = nil;
        Book *book = nil;
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        if (!error && jsonData) {
            NSDictionary *bookDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:0
                                                                       error:&error];
            if (!error && bookDict) {
                if ([bookDict[@"error"] isEqualToString:@"0"]) {
 s
                    book = [Book bookWithBuilder:^(BookBuilder *builder) {
                        builder.title = bookDict[@"title"];
                        builder.title = bookDict[@"title"];
                        builder.subTitle = bookDict[@"subtitle"];
                        builder.isbn13 = bookDict[@"isbn13"];
                        builder.isbn13 = bookDict[@"isbn13"];
                        builder.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                                [NSURL URLWithString:bookDict[@"image"]]]];
                        builder.url = bookDict[@"url"];
                        builder.rating = bookDict[@"rating"];
                        builder.desc = bookDict[@"desc"];
                        builder.author = bookDict[@"author"];
                        builder.publication = bookDict[@"publication"];
                    }];
                    
                } else {
                    NSLog(@"Error returned by server retriving books, error = %@", bookDict[@"error"]);
                }
            } else {
                NSLog(@"Error - json serialization, error = %@", error);
            }
        } else {
            NSLog(@"Error - retriving json data, error = %@", error);
        }
        completionBlock([book copy]);
    });
}

@end
