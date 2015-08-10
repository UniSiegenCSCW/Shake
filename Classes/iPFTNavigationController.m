//
//  iPFTNavigationController.m
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

#import "iPFTNavigationController.h"


@implementation iPFTNavigationController


@synthesize imageParentView = _imageParentView;
@synthesize imageViewBackground = _imageViewBackground;


#pragma mark - View lifecycle


- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Basic setup
    [self initData];
}


#pragma mark - Instance methods


- (void) initData {
    
    // Set image as backgorund image
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    CGRect windowFrame = window.bounds;
    _imageViewBackground = [[UIImageView alloc] initWithFrame:windowFrame];
    _imageViewBackground.image = _imageParentView;
    
    // Add backgroundimage to the view hierarchie
    [self.view insertSubview:_imageViewBackground atIndex:0];
    self.view.clipsToBounds = NO;
}


#pragma mark - Autorotation stuff


- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    
    // For the feedback tool we only want portrait orientation
    return UIInterfaceOrientationPortrait;
}


- (BOOL) shouldAutorotate {
    
    // For the feedback tool we only want portrait orientation
    return NO;
}


@end
