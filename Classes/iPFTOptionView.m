//
//  iPFTOptionView.m
//  iPhoneFeedbackTool
//
//  Created by Christian Neumann on 07.06.15.
//  Copyright (c) 2015 Christian Neumann, University of Siegen. All rights reserved.
//
//  The MIT License (MIT)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


#import "iPFTOptionView.h"


@implementation iPFTOptionView


@synthesize delegate = _delegate;
@synthesize buttonSwitch = _buttonSwitch;


#pragma mark - Initialization


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if ( self ) {
        
        // Add the custom view to this view
        [self addButtonToView];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if ( self ) {
        
        // Add the custom view to this view
        [self addButtonToView];
    }
    return self;
}


- (instancetype)init {
    
    self = [super init];
    if ( self ) {
        
        // Add the custom view to this view
        [self addButtonToView];
    }
    return self;
}


#pragma mark - Instance methods


- (void) addButtonToView {
    
    // Set transparent background
    self.backgroundColor = [UIColor clearColor];
    
    // Initialize the button and add target and action
    _buttonSwitch = [UIButton buttonWithType:UIButtonTypeSystem];
    [_buttonSwitch setFrame:self.bounds];
    [_buttonSwitch addTarget:self action:@selector(buttonSwitchStatusPressed:) forControlEvents:UIControlEventTouchDown];
    _buttonSwitch.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _buttonSwitch.layer.borderWidth = 3.0;
    _buttonSwitch.layer.cornerRadius = 7.0;
    _buttonSwitch.clipsToBounds = YES;
    
    // Add button image
    [_buttonSwitch setImage:[UIImage imageNamed:@"iPFT_Option"] forState:UIControlStateNormal];
    
    // Add the button to the view
    [self addSubview:_buttonSwitch];
    
    // Set to display initial status
    [self setEnabled:NO];
}


- (void) setEnabled:(BOOL)value {
    
    // Set to display selected state
    if ( value ) {
        
        _buttonSwitch.tintColor = RGB(0, 180, 0);
    }
    
    // Set to display unselected state
    else {
        
        _buttonSwitch.tintColor = RGB(55, 55, 55);
    }
}


#pragma mark - IBActions


- (void) buttonSwitchStatusPressed:(id)sender {
    
    // Check if the delegate implemented the protocol methods
    if ( _delegate && [_delegate respondsToSelector:@selector(switchStatus:)] ) {
        
        // Call the protocol method on the delegate and set self as the sender
        [_delegate switchStatus:self];
    }
}


@end
