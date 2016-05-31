//
//  ViewController.m
//  Hangman
//
//  Created by tstone10 on 5/31/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSArray *wordArray;
NSMutableArray *newWordArray;
NSMutableArray *letterArray;
NSString *currentWord;
int hangmanCount;

- (void)viewDidLoad {
    [super viewDidLoad];
    wordArray = @[@"Canada", @"America", @"France", @"China", @"Nepal", @"Phillipines", @"India", @"Germany", @"Korea", @"Japan", @"Sweden", @"England", @"Italy", @"Mexico", @"Denmark", @"Greece", @"Spain", @"Brazil", @"Venezuela", @"Chile"];
    [self shovelWordArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) resetHangmanAndResetWord {
    [self resetHangman];
}

-(void)shovelWordArray{
    newWordArray = [wordArray mutableCopy];
    
    //exchangeObjectAtIndex only works when there are 2 items in the array.
    for (NSInteger i = newWordArray.count-1; i > -1; i--) {
        [newWordArray exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((u_int32_t)(i+1))];
    }
    
    //test the shovel function and it works!
    [newWordArray enumerateObjectsUsingBlock:^(id obj,
                                            NSUInteger idx,
                                            BOOL *stop) {
        NSLog(@"%ld: %@", idx, obj);
    }];
    [self selectWord];
}

- (void) resetHangman {
    // placeholder with counter instead of images for logic
    hangmanCount = 0;
}

- (void) selectWord {
    // select first word for testing
//    for (NSString *word in wordArray) {
//        currentWord = word;
//        NSLog(@"currentWord = %@", currentWord);
//    }
    currentWord = newWordArray[0];
    NSLog(@"currentWord = %@", currentWord);
    [self resetHangmanAndResetWord];
}

//- (void) createLetterArray {
//    int i;
//    for (i = 0; i <= currentWord.length; i++) {
//        letterArray[i]
//    }
//}

- (IBAction)guessLetter:(UIButton *)sender {
}

@end
