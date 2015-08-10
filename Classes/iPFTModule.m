//
//  iPFTModule.m
//  iPhoneFeedbackTool
//
//  Created by Christian Neumann on 07.05.15.
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

#import "iPFTModule.h"

@implementation iPFTModule


@synthesize dictModuleData = _dictModuleData;
@synthesize delegate = _delegate;
@synthesize arraySubmitData = _arraySubmitData;


#pragma mark - Initialization


- (id) init {
    
    self = [super init];
    if ( self ) {
        
        // Load the modules data from the module plist
        [self loadModuleDataFromPlist];
    }
    return self;
}


#pragma mark - Instance methods


- (void) send:(NSArray *)submitData {
    
    // Set submit data
    _arraySubmitData = submitData;
    
    // Check sending status
    if ( _sending ) return;
    
    // Set sending status to yes
    _sending = YES;
}


- (void) loadModuleDataFromPlist {
    
    // Get the plist path
    NSString *pathToResource = [[NSBundle mainBundle] pathForResource:NSStringFromClass([self class]) ofType:@"plist"];
    
    // Exit this method if no plist was found
    if ( pathToResource == nil ) return;
    
    //Load dictionary object from module plist plist
    self.dictModuleData = [NSDictionary dictionaryWithContentsOfFile:pathToResource];
}

@end
