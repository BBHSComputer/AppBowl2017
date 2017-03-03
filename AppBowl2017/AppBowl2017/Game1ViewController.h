//
//  Game1ViewController.h
//  AppBowl2017
//
//  Created by Ethan Tillison on 2/3/17.
//  Copyright © 2017 Blind Brook Computer Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Game1ViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) NSMutableArray *imageViews;

- (void)layoutImages:(int)numberOfImages;

- (void)flipImage:(NSInteger)image;

- (void)imagePressed:(UIButton *)sender;

@end
