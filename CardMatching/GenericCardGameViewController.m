//
//  ViewController.m
//  CardMatching
//
//  Created by Stuart Nelson on 8/3/15.
//  Copyright (c) 2015 Stuart Nelson. All rights reserved.
//

#import "GenericCardGameViewController.h"
#import "Deck.h"

@interface GenericCardGameViewController ()
@property (strong, nonatomic) NSMutableArray *history;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
- (IBAction)resetGame:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
- (IBAction)switchGameMode:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@end

typedef NS_ENUM(NSUInteger, SelectedSegmentIndex) {
    SelectedSegmentIndexTwoCard = 0,
    SelectedSegmentIndexThreeCard = 1,
};

@implementation GenericCardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    
    return _game;
}

- (Deck *)createDeck
{
    return nil;
}

- (NSArray *)history
{
    if (!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if (self.gameMode.userInteractionEnabled) {
        self.gameMode.userInteractionEnabled = NO;
        self.gameMode.tintColor = [UIColor grayColor];
    }
    
    NSInteger cardIndex = [self.cardButtons indexOfObject:sender];
    NSString *result = [self.game chooseCardAtIndex:cardIndex];

    if (result != nil) {
        [self.history addObject:result];
    }
    [self updateUI];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"history"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
            hvc.history = [[NSArray alloc] initWithArray:self.history];
        }
    }
}

- (IBAction)resetGame:(id)sender
{
    _game = nil;
    _history = nil;
    
    [self updateUI];
    self.gameMode.userInteractionEnabled = YES;
    self.gameMode.tintColor = [UIColor whiteColor];
    [self setup];
}

- (void) setup{}

- (void)updateUI
{
    for (UIButton *button in self.cardButtons) {
        int cardIndex = (int)[self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:cardIndex];
        [button setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        button.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (NSMutableAttributedString *)titleForCard:(Card *)card
{
    if (card.isChosen) {
        return [[NSMutableAttributedString alloc] initWithString:card.contents];
    }
    
    return [[NSMutableAttributedString alloc] initWithString:@""];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed: card.isChosen ? @"front" : @"back"];
}

- (IBAction)switchGameMode:(id)sender
{
    switch (self.gameMode.selectedSegmentIndex) {
        case SelectedSegmentIndexTwoCard:
            [self.game twoCardMode];
            break;
        case SelectedSegmentIndexThreeCard:
            [self.game threeCardMode];
            break;
    }
}
@end
