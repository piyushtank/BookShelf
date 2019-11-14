//
//  Book.h
//  BookShelf
//
//  Created by Bhavisha Tank on 11/10/19.
//  Copyright © 2019 PiyushTank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Book : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *isbn13;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *url;

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                       isbn13:(NSString *)isbn13
                        price:(NSString *)price
                     imageUrl:(NSString *)imageUrl
                          url:(NSString *)url;


@end
