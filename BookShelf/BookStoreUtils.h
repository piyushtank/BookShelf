//
//  BookStoreUtils.h
//  BookShelf
//
//  Created by Bhavisha Tank on 11/16/19.
//  Copyright © 2019 PiyushTank. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Book;

@interface BookStoreUtils : NSObject

+ (void)getBooksWithUrlString:(nonnull NSString *)urlString
              completionBlock:(nonnull void (^) (NSArray<Book *> * _Nonnull books))completionBlock;

@end
