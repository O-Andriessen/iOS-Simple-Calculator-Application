//
//  ViewController.m
//  Calculator
//
//  Created by Olivier Andriessen on 19/01/14.
//  Copyright (c) 2014 Olivier Andriessen. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CustomColors.h"

@interface ViewController ()

@end

@implementation ViewController {
    int                 currentColor;
    BOOL                firstOperand,
                        useResultFromMemory;
    char                operator;
    NSMutableString     *displayValue;
    NSTimer             *eraseButtonTimer;
}

@synthesize firstEnteredValue, secondEnteredValue, resultValue, displayLabel, eraseButton;


#pragma mark - Main methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUserInterfaceColor];
    [self clearEverything];
    firstOperand = YES;
    displayValue = [NSMutableString stringWithCapacity:40];
    eraseButtonTimer = [[NSTimer alloc] init];
}

#pragma mark - Display methods

- (void)showEraseButton {
    [UIView animateWithDuration:0.5 animations:^{
        self.eraseButton.alpha = 1.0f;
    }];
}

- (IBAction)beginErase {
    [self eraseDigit];
    eraseButtonTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(eraseDigit) userInfo:nil repeats:YES];
}

- (void)eraseDigit {
    if (![displayValue isEqualToString:@""]){
        AudioServicesPlaySystemSound(0x450);
        [displayValue deleteCharactersInRange:NSMakeRange([displayValue length]-1, 1)];
        if ([displayValue length] == 0){
            self.eraseButton.alpha = 0.0f;
        }
    } else if (eraseButtonTimer != nil){
        [eraseButtonTimer invalidate];
        eraseButtonTimer = nil;
    }
    displayLabel.text = displayValue;
}

- (IBAction)endErase {
    if (eraseButtonTimer != nil)
        [eraseButtonTimer invalidate];
    eraseButtonTimer = nil;
}

#pragma mark - Operator methods

- (IBAction)clickDigit: (UIButton *) sender {
    if (((int)sender.tag == 0 && [displayValue isEqualToString:@""]) || ((int)sender.tag == 0 && [displayValue isEqualToString:@"-"])){
        NSLog(@"Can't insert 0 if display is at zero.");
    } else {
        displayLabel.text = displayValue;
        [self showEraseButton];
        [self deselectOpButtons];
        [displayValue appendString:[NSString stringWithFormat:@"%d", (int)sender.tag]];
    }
    displayLabel.text = displayValue;
}

- (IBAction)clickComma {
    NSRange range = [displayValue rangeOfString:[NSString stringWithFormat:@"."]];
    if (range.location == NSNotFound)
    {
        [self showEraseButton];
        [displayValue appendString:@"."];
        displayLabel.text = displayValue;
    }
}

- (IBAction)clickOperator:(UIButton *)sender {
    
    [self deselectOpButtons];
    [self processEnteredValue];
    
    switch ((int)sender.tag){
        case 1: // Percent Operator
            operator = '%';
            firstOperand = NO;
            [self clickEquals];
            break;
        case 2: // Divide Operator
            operator = '/';
            self.divideButton.selected = YES;
            break;
        case 3: // Multiply Operator
            operator = '*';
            self.multiplyButton.selected = YES;
            break;
        case 4: // Subtract Operator
            operator = '-';
            self.subtractButton.selected = YES;
            break;
        case 5: // Add Operator
            operator = '+';
            self.addButton.selected = YES;
            break;
    }
    
    
    firstOperand = NO;
    
}

- (IBAction)clickPlusMinus {
    if ([displayValue doubleValue] >= 0 && ![displayValue isEqualToString:@"-"]) {
        [displayValue insertString:@"-" atIndex:0];
        [self showEraseButton];
    } else if ([displayValue doubleValue] < 0){
        [displayValue deleteCharactersInRange:NSMakeRange(0, 1)];
    } else if ([displayValue isEqualToString:@"-"]){
        [displayValue deleteCharactersInRange:NSMakeRange(0, 1)];
        self.eraseButton.alpha = 0.0f;
    }
    displayLabel.text = displayValue;
}

- (IBAction)clickEquals {
    if (firstOperand){
        if (useResultFromMemory) {
            useResultFromMemory = NO;
            [self processEnteredValue];
            [self processSum];
            [displayValue setString:[NSString stringWithFormat:@"%lg", resultValue]];
            displayLabel.text = displayValue;
        }
    } else {
        [self processEnteredValue];
        [self processSum];
        [displayValue setString:[NSString stringWithFormat:@"%lg", resultValue]];
        displayLabel.text = displayValue;
    }
    firstOperand = YES;
}

- (IBAction)clearEverything {
    [displayValue setString:@""];
    displayLabel.text = @"";
    firstEnteredValue = 0;
    secondEnteredValue = 0;
    operator = 0;
    firstOperand = YES;
    useResultFromMemory = NO;
    self.eraseButton.alpha = 0.0f;
}

#pragma mark - Process methods

- (IBAction)deselectOpButtons {
    self.addButton.selected = NO;
    self.subtractButton.selected = NO;
    self.multiplyButton.selected = NO;
    self.divideButton.selected = NO;
}

- (void)processEnteredValue {
    if (firstOperand) {
        if (useResultFromMemory) {
            firstEnteredValue = resultValue;
            [displayValue setString:@""];
            secondEnteredValue = [displayValue doubleValue];
        } else {
            firstEnteredValue = [displayValue doubleValue];
            [displayValue setString:@""];
        }
    } else {
        secondEnteredValue = [displayValue doubleValue];
        [displayValue setString:@""];
    }
}

- (void)processSum {
    switch (operator) {
        case '+':
            resultValue = firstEnteredValue + secondEnteredValue;
            break;
            
        case '-':
            resultValue = firstEnteredValue - secondEnteredValue;
            break;
            
        case '*':
            resultValue = firstEnteredValue * secondEnteredValue;
            break;
            
        case '/':
            resultValue = firstEnteredValue / secondEnteredValue;
            break;
            
        case '%':
            resultValue = firstEnteredValue / 100;
            break;
            
        default:
            resultValue = firstEnteredValue;
            break;
    }
    
    useResultFromMemory = YES;
    
}

#pragma mark - User Interface methods

- (IBAction)clickButton {
    AudioServicesPlaySystemSound(0x450);
}

- (IBAction)setUserInterfaceColor {
    NSMutableString *interfaceColor = [[NSMutableString alloc] initWithCapacity:20];
    switch (currentColor){
        case 0:
            [interfaceColor setString:@"grey"];
            break;
        case 1:
            [interfaceColor setString:@"green"];
            break;
        case 2:
            [interfaceColor setString:@"yellow"];
            break;
        case 3:
            [interfaceColor setString:@"orange"];
            break;
        case 4:
            [interfaceColor setString:@"red"];
            break;
        case 5:
            [interfaceColor setString:@"purple"];
            break;
        case 6:
            [interfaceColor setString:@"blue"];
            break;
        default:
            [interfaceColor setString:@"grey"];
            break;
    }

    for (UIButton *keypadButton in self.keypadButtons) {
        [keypadButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"button-%@.png", interfaceColor]] forState:UIControlStateNormal];
        [keypadButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"button-%@-highlighted.png", interfaceColor]] forState:UIControlStateHighlighted];
        [keypadButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"button-%@-highlighted.png", interfaceColor]] forState:UIControlStateSelected];
        [keypadButton setTitleColor:[UIColor color:interfaceColor] forState:UIControlStateNormal];
    }
    
    self.view.backgroundColor = [UIColor color:[NSString stringWithFormat:@"light%@", interfaceColor]];
    
    self.displayLabel.textColor = [UIColor color:interfaceColor];
    
    self.displayView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"display-%@.png", interfaceColor]]];
    [self.eraseButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"button-back-%@.png", interfaceColor]] forState:UIControlStateNormal];
    [self.changeColorButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"button-cc-%@.png", interfaceColor]] forState:UIControlStateNormal];
    [self.changeColorButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"button-cc-%@-highlighted.png", interfaceColor]] forState:UIControlStateHighlighted];

    (currentColor == 6 ? currentColor = 0 :currentColor++);
}



@end
