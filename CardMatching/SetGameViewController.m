//
//  SetGameViewController.m
//  CardMatching
//
//  Created by Stuart Nelson on 11/14/15.
//  Copyright © 2015 Stuart Nelson. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetDeck.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController
- (void)viewDidLoad
{
    [self.game threeCardMode];
}

- (Deck *)createDeck
{
    return [[SetDeck alloc] init];
}
@end
