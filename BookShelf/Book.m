//
//  Book.m
//  BookShelf
//
//  Created by Bhavisha Tank on 11/10/19.
//  Copyright © 2019 PiyushTank. All rights reserved.
//

#import "Book.h"

@implementation Book

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                       isbn13:(NSString *)isbn13
                        price:(NSString *)price
                     imageUrl:(NSString *)imageUrl
                          url:(NSString *)url {
    self = [super init];
    if (self) {
        _title = title;
        _subTitle = subTitle;
        _isbn13 = isbn13;
        _price = price;
        _image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                         [NSURL URLWithString:imageUrl]]];
        _url = url;
    }
    return self;
}

@end
