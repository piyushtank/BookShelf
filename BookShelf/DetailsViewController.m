//
//  DetailsViewController.m
//  BookShelf
//
//  Created by Piyush Tank on 11/17/19.
//  Copyright © 2019 PiyushTank. All rights reserved.
//

#import "DetailsViewController.h"
#import "BookStoreUtils.h"
#import "Book.h"

@interface DetailsViewController () <UITextViewDelegate>

@property (nonatomic, strong) Book *book;

@end

@implementation DetailsViewController

static NSString * const kDetailsURLString = @"https://api.itbook.store/1.0/books/";

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    self.navigationItem.title = @"Details";
    self.hyperLinkTextView.delegate = self;
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kDetailsURLString, self.isbn13];
    
    [BookStoreUtils getBookDetailsWithUrlString:urlString
                                completionBlock:^(Book *book) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.book = book;
        dispatch_async(dispatch_get_main_queue(), ^{
            strongSelf.imageView.image = book.image;
            strongSelf.titleLabel.text = book.title;
            strongSelf.subtitleLabel.text = [NSString stringWithFormat:@"By %@\n\nRating: %@\n\nPrice: %@", book.authors, book.rating, book.price];
            
            strongSelf.hyperLinkTextView.attributedText = [[NSAttributedString alloc] initWithString:@"Click here for more details"
                                                                                          attributes:@{ NSLinkAttributeName: [NSURL URLWithString:book.url] }];
            strongSelf.hyperLinkTextView.editable = NO;
            strongSelf.hyperLinkTextView.dataDetectorTypes = UIDataDetectorTypeAll;
            strongSelf.detailsLabel.text = [NSString stringWithFormat:@"Subtitle: %@\n\n Publication: %@\n\nYear: %@\n\nPages: %@", book.subTitle, book.publisher, book.year, book.pages];

        });
    }];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL
         inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    return YES;
}

@end
