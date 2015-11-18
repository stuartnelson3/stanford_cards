//
//  MatchingCardGameViewController.m
//  CardMatching
//
//  Created by Stuart Nelson on 11/14/15.
//  Copyright © 2015 Stuart Nelson. All rights reserved.
//

#import "MatchingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface MatchingCardGameViewController ()

@end

@implementation MatchingCardGameViewController
- (void)viewDidLoad
{
    self.title = @"Matching Card Game";
    [self setup];
}

- (void)setup
{
    [self.game twoCardMode];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}
@end
