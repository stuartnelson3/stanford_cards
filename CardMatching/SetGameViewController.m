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
@property (strong, nonatomic) NSDictionary *colors;
@property (strong, nonatomic) NSDictionary *shading;
@end

@implementation SetGameViewController
- (void)viewDidLoad
{
    self.title = @"Set Game";
    [self setup];
}

- (Deck *)createDeck
{
    NSArray *symbols = @[@"◼︎", @"▲", @"●"];
    NSArray *colors = @[@"purple", @"red", @"green"];
    return [[SetDeck alloc] initWithColors:colors withSymbols:symbols];
}

- (void)setup
{
    [self.game threeCardMode];
}

- (NSAttributedString *)titleForCard:(SetCard *)card
{
    if (!card.isChosen) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    
    NSMutableAttributedString *contents =
        [[NSMutableAttributedString alloc] initWithString:card.contents];
    [contents setAttributes:@{
                              NSForegroundColorAttributeName : [self getColor:card.color],
                              NSStrokeWidthAttributeName : [self getShading:card.shading],
                              NSStrokeColorAttributeName : [UIColor grayColor],
                              }
                      range:NSMakeRange(0, [contents length])];

    return contents;
}

- (UIColor *)getShading:(NSString *)shading
{
    if (!_shading) {
        _shading = @{
                     @"solid":@0,
                     @"striped":@-10,
                     @"open":@10,
                     };
    }
    return [self.shading objectForKey:shading];
}

- (UIColor *)getColor:(NSString *)color
{
    if (!_colors) {
        _colors = @{
                    @"purple":[UIColor purpleColor],
                    @"red":[UIColor redColor],
                    @"green":[UIColor greenColor],
                    };
    }
    return [self.colors objectForKey:color];
}
@end
