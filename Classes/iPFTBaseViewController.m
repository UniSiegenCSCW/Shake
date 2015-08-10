//
//  iPFTBaseViewController.m
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

#import "iPFTBaseViewController.h"
#import "iPFTHelpViewController.h"


@implementation iPFTBaseViewController


@synthesize submitData = _submitData;


#pragma mark - View lifecycle


- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self initData];
}


#pragma mark - Instance methods


- (void) initData {
    
    // Hide status bar
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    // Set the desired orientation
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}


- (void) addHelpButtonAsRightNavbarButton {
    
    // Initialize a help button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [button addTarget:self action:@selector(helpButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonHelp = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    // Add it to the navigation bar
    self.navigationItem.rightBarButtonItem = buttonHelp;
}


- (void) addDoneButtonAsRightNavbarButton {
    
    // Iniitalize Done Button
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(doneButtonPressed:)];
    
    // Add it to the navigation bar
    self.navigationItem.rightBarButtonItem = buttonDone;
}


- (void) resignAllResponders {

    // Empty implementation
}


#pragma mark - View Auto-Rotation


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    // For the feedback tool we only want portrait orientation
    return NO;
}


- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    
    // For the feedback tool we only want portrait orientation
    return UIInterfaceOrientationPortrait;
}


- (NSUInteger) supportedInterfaceOrientations {
    
    // For the feedback tool we only want portrait orientation
    return UIInterfaceOrientationMaskPortrait;
}


- (BOOL) shouldAutorotate {
    
    // For the feedback tool we only want portrait orientation
    return NO;
}


#pragma mark - Statusbar visibility


- (BOOL) prefersStatusBarHidden {
    
    // Hide status bar (needed in case there is no appropriate option set in info.plist)
    return YES;
}


#pragma mark - IBActions


- (IBAction) cancelButtonPressed:(id)sender {
    
    // Close the current view and go back to the main app
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction) doneButtonPressed:(id)sender {
    
    // Resign first responders
    [self resignAllResponders];
}


- (IBAction) helpButtonPressed:(id)sender {
    
    // Initialize a new help view controller
    iPFTHelpViewController *viewHelp = [[iPFTHelpViewController alloc] initWithNibName:@"iPFTHelpViewController" bundle:nil];
    UINavigationController *navHelp = [[UINavigationController alloc] initWithRootViewController:viewHelp];
    navHelp.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    navHelp.toolbar.barStyle = UIBarStyleBlackTranslucent;
    navHelp.navigationBar.tintColor = [UIColor lightTextColor];
    navHelp.toolbar.tintColor = [UIColor lightTextColor];
    [navHelp setNavigationBarHidden:NO];
    [navHelp setToolbarHidden:NO];
    
    // Add this to achieve a transparent modal view
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    [navHelp setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    // Present the modal view
    [self.navigationController presentViewController:navHelp animated:YES completion:nil];
}


- (IBAction) nextButtonPressed:(id)sender {
    
    // Empty implementation
}


@end
