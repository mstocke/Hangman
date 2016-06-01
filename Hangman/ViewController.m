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

//MARK: - Properties
NSArray *wordArray;
NSMutableArray *newWordArray;
NSMutableArray *letterArray;
NSMutableArray *labelArray;
NSString *currentWord;
int hangmanCount;
int correctCount;


//MARK: - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWordArray];
    [self resetGame];
    [self stringConvertToArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//MARK: - Interactivity Methods

    //1.initWordArray
-(void)initWordArray{
        wordArray = @[@"Canada", @"America", @"France", @"China", @"Nepal", @"Phillipines", @"India", @"Germany", @"Korea", @"Japan", @"Sweden", @"England", @"Italy", @"Mexico", @"Denmark", @"Greece", @"Spain", @"Brazil", @"Venezuela", @"Chile"];
}

    //2. randomize wordArr and assign to newArr
-(void)shovelWordArray{
    newWordArray = [wordArray mutableCopy];
    //exchangeObjectAtIndex only works when there are 2 items in the array.
    for (NSInteger i = newWordArray.count-1; i > -1; i--) {
        [newWordArray exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((u_int32_t)(i+1))];
    }
    //test the shovel function and it works!
    [newWordArray enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop) {
        NSLog(@"%ld: %@", idx, obj);
    }];
}

    //1+2+3
- (void) resetGame {
    [self shovelWordArray];
    hangmanCount = 0;
    correctCount = 0;
    self.inputTextField.text = @"";
    [self newGameInterval];
    
}

- (void) newGameInterval {
    int wordIndex = 0;
    while (wordIndex < newWordArray.count) {
        currentWord = wordArray[wordIndex];
        NSLog(@"The current is %@",currentWord);
        NSLog(@"CHECK THE WORD, FUNCTION HERE");
        [self checkWord];
        hangmanCount = 0;
        if (hangmanCount == 0){
            wordIndex = (int) newWordArray.count;
            [self alertLose];
        }
        if (wordIndex == newWordArray.count-1) {
            [self alertWin];
        }
        wordIndex ++;
    }
}

-(void)alertLose{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"you lose!"
                                  message:@"Play again?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self resetGame];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)alertWin{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"You win!"
                                  message:@"Play again?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             [self resetGame];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)stringConvertToArray{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i=0; i < currentWord.length; i++) {
        NSString *tmp_str = [currentWord substringWithRange:NSMakeRange(i, 1)];
        [arr addObject:[tmp_str stringByRemovingPercentEncoding]];
    }
    letterArray = arr;
    NSLog(letterArray.description);
}

-(void)checkWord{
    [self initLabelArr];
    [self assignLabels];

}

-(void)initLabelArr{
    labelArray = [[NSMutableArray alloc] initWithObjects:_letterLabel0,_letterLabel1,_letterLabel2,_letterLabel3,_letterLabel4,_letterLabel5,_letterLabel6,_letterLabel7,_letterLabel8,_letterLabel9,_letterLabel0, nil];
}

//5. after letterArr count of letterLabel, set text to be ""
-(void)assignLabels{
    for(int i =0; i<labelArray.count; i++){
        UILabel *currentUILabel = labelArray[i];
        if (i<letterArray.count-1) {
            NSString *currentChar = letterArray[i];
            currentUILabel.text =  [NSString stringWithFormat:@"%@",currentChar];
            NSLog(currentChar);
        }else{
        currentUILabel.text = @"";
        }
        
    
    }

}



- (IBAction)guessLetter:(UIButton *)sender {
    
}

@end
