//
//  DetailsViewController.h
//  BookShelf
//
//  Created by Piyush Tank on 11/17/19.
//  Copyright © 2019 PiyushTank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UITextView *hyperLinkTextView;

@property (nonatomic, strong) NSString* isbn13;

@end
