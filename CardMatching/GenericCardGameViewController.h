//
//  ViewController.h
//  CardMatching
//
//  Created by Stuart Nelson on 8/3/15.
//  Copyright (c) 2015 Stuart Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface GenericCardGameViewController : UIViewController

@property (nonatomic, strong) CardMatchingGame *game;

- (Deck *)createDeck;

@end

