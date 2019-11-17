//
//  Book.m
//  BookShelf
//
//  Created by Bhavisha Tank on 11/10/19.
//  Copyright © 2019 PiyushTank. All rights reserved.
//

#import "Book.h"

@implementation BookBuilder
@end

@implementation Book

+ (instancetype)bookWithBuilder:(void (^)(BookBuilder *))builderBlock {
    BookBuilder *builder = [BookBuilder new];
    builderBlock(builder);
    return [[Book alloc] initWithBuilder:builder];
    
}

- (instancetype)initWithBuilder:(BookBuilder *)builder {
    self = [super init];
    if (self) {
        _title = builder.title;
        _subTitle = builder.subTitle;
        _isbn13 = builder.isbn13;
        _price = builder.price;
        _image = builder.image;
        _url = builder.url;
        _rating = builder.rating;
        _desc = builder.desc;
        _author = builder.author;
        _publication = builder.publication;
    }
    return self;
}



@end
