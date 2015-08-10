//
//  iPFTLogViewController.m
//  iPhoneFeedbackTool
//
//  Created by Christian Neumann on 25.05.15.
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

#import "iPFTLogViewController.h"


@implementation iPFTLogViewController


@synthesize segmentedSelectLog = _segmentedSelectLog;
@synthesize textStacktrace = _textStacktrace;
@synthesize textApplicationLog = _textApplicationLog;
@synthesize labelLogViewDesc = _labelLogViewDesc;


#pragma mark - Instance methods


- (void) initData {

    [super initData];
    
    // Set this views description
    _labelLogViewDesc.text = iPFTLocalizedString(@"iPFT_VIEWLOG_DESC");
    
    // Add BarButtonItems to the toolbar
    UIBarButtonItem *fixSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                              target:nil
                                                                              action:nil];
    fixSpace.width = 10.0;
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:nil];
    
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_DONE")
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(cancelButtonPressed:)];
    NSArray *arrayItems = [[NSArray alloc] initWithObjects:flexSpace, buttonDone, fixSpace, nil];
    
    [self setToolbarItems:arrayItems];
    
    // Config segmented control
    [_segmentedSelectLog setTitle:iPFTLocalizedString(@"iPFT_SEGMENT_STACK") forSegmentAtIndex:DISPLAY_STACK];
    [_segmentedSelectLog setTitle:iPFTLocalizedString(@"iPFT_SEGMENT_LOG") forSegmentAtIndex:DISPLAY_LOG];
    
    // Fill textviews
    _textStacktrace.text = self.submitData.stacktrace;
    _textApplicationLog.text = self.submitData.log;
    _textStacktrace.textColor = [UIColor lightTextColor];
    _textApplicationLog.textColor = [UIColor lightTextColor];
    
    // Config initial appearance
    [self setDisplay:DISPLAY_STACK];
}


- (void) setDisplay:(NSUInteger)index {
    
    switch (index) {
            
        case DISPLAY_STACK:
            // Set this views title
            self.title = iPFTLocalizedString(@"iPFT_TITLE_VIEWSTACK");
            
            // Set visibility status for the textviews
            _textApplicationLog.hidden = YES;
            _textStacktrace.hidden = NO;
            break;
            
        case DISPLAY_LOG:
            // Set this views title
            self.title = iPFTLocalizedString(@"iPFT_TITLE_VIEWLOG");
            
            // Set visibility status for the textviews
            _textApplicationLog.hidden = NO;
            _textStacktrace.hidden = YES;
            break;
            
        default:
            break;
    }
}


#pragma mark - iPFTOptionsDelegate



#pragma mark - IBActions


- (IBAction) segmentedControlChanged:(id)sender {
    
    // Securely cast the sender
    if ( [sender isKindOfClass:[UISegmentedControl class]] ) {
        
        // Update display
        [self setDisplay:[(UISegmentedControl *)sender selectedSegmentIndex]];
    }
}


@end
