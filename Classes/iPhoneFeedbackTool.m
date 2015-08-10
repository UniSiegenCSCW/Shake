//
//  iPhoneFeedbackTool.m
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

#import "iPhoneFeedbackTool.h"

@implementation iPhoneFeedbackTool


#pragma mark - Initialization


- (id) init {
    
    self = [super init];
    if (self) {
        
        // Subscribe to shake gesture event notifications
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(shakeGestureDetected:)
                                                     name:@"ShakeGestureDetectedNotification"
                                                   object:nil];
        
        // Subscribe to displayMainFeedbackViewController notifications
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(displayMainFeedbackViewController)
                                                     name:@"displayMainFeedbackViewController"
                                                   object:nil];
    }
    return self;
}


#pragma mark - Instance methods


- (void) shakeGestureDetected:(NSNotification *)notification {

    // Check if the shake event should be processed (and exit this method if there is an active feedbacktool dialog) 
    if ( [iPFTPersistence getBlockShakeGesture] ) return;
    
    // Display information view controller, if needed
    if ( ![iPFTPersistence hasInfoBeenShown] || ALWAYS_SHOW_INFO_VIEW ) {
    
        // Vibrate the phone to give some extra physical feedback
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        [self displayInformationViewController];
        return;
    }
    
    // Display main view controller to let the user enter his feedback
    [self displayMainFeedbackViewController];
}


- (void) displayInformationViewController {
    
    // Initialize a new info view controller
    iPFTInfoViewController *viewInfo = [[iPFTInfoViewController alloc] initWithNibName:@"iPFTInfoViewController" bundle:nil];

    // Get a reference to the main window and take a screenshot
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    viewInfo.imageParentView = [iPFTSubmitData captureView:window.rootViewController.view];
    
    // Present the modal view
    [window.rootViewController presentViewController:viewInfo animated:NO completion:nil];
}


- (void) displayMainFeedbackViewController {
    
    // Initialize a new main view controller
    iPFTMainViewController *viewMain = [[iPFTMainViewController alloc] initWithNibName:@"iPFTMainViewController" bundle:nil];
    iPFTNavigationController *navMain = [[iPFTNavigationController alloc] initWithRootViewController:viewMain];
    navMain.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    navMain.toolbar.barStyle = UIBarStyleBlackTranslucent;
    navMain.navigationBar.tintColor = [UIColor lightTextColor];
    navMain.toolbar.tintColor = [UIColor lightTextColor];
    [navMain setNavigationBarHidden:YES];
    [navMain setToolbarHidden:YES];
    
    // Get a reference to the main window and take a screenshot
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    navMain.imageParentView = [iPFTSubmitData captureView:window.rootViewController.view];
    
    // Present the modal view
    [window.rootViewController presentViewController:navMain animated:NO completion:nil];
}


#pragma mark - Memory management


- (void) dealloc {
    
    // Unsubscribe from NSNotification messages
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Singleton implementation

// This holds the singleton instance of this class
static iPhoneFeedbackTool *sharedInstance = nil;


// Returns the singleton instance and initializes
+ (iPhoneFeedbackTool *) sharedInstance {
    
    @synchronized(self)
    {
        if (sharedInstance == nil) {
   
            // Initialization
            sharedInstance = [[iPhoneFeedbackTool alloc] init];
        }
    }
    
    return sharedInstance;
}


@end
