//
//  Book.h
//  BookShelf
//
//  Created by Piyush Tank on 11/10/19.
//  Copyright © 2019 PiyushTank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BookBuilder : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *isbn13;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) UIImage *image;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *authors;
@property (nonatomic, copy) NSString *publisher;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *pages;

@end

@interface Book : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *subTitle;
@property (nonatomic, strong, readonly) NSString *isbn13;
@property (nonatomic, strong, readonly) NSString *price;
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, strong, readonly) NSString *url;
@property (nonatomic, strong, readonly) NSString *rating;
@property (nonatomic, strong, readonly) NSString *desc;
@property (nonatomic, strong, readonly) NSString *authors;
@property (nonatomic, strong, readonly) NSString *publisher;
@property (nonatomic, strong, readonly) NSString *year;
@property (nonatomic, strong, readonly) NSString *pages;

+ (instancetype)bookWithBuilder:(void (^)(BookBuilder *))builderBlock;

@end
