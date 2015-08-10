//
//  iPFTMainViewController.m
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

#import "iPFTMainViewController.h"


@implementation iPFTMainViewController


@synthesize imageScreenshot = _imageScreenshot;
@synthesize viewAnnotations = _viewAnnotations;
@synthesize viewPaint = _viewPaint;
@synthesize labelDescription = _labelDescription;
@synthesize segmentedBrushes = _segmentedBrushes;
@synthesize viewTouchEvent = _viewTouchEvent;
@synthesize labelTouchEvent = _labelTouchEvent;


#pragma mark - Instance methods


- (void) initData {

    [super initData];
    
    // Create an empty iPFTSubmitData object
    self.submitData = [[iPFTSubmitData alloc] init];
    
    // Set this views title
    self.title = iPFTLocalizedString(@"iPFT_TITLE_MAIN");
    
    // Disable processing of further shake gestures
    [iPFTPersistence setBlockShakeGesture:YES];
    
    // Add help button to the navigation bar
    [self addHelpButtonAsRightNavbarButton];
    
    // Add edit button to the navigation bar that enables drawing
    [self addEditButtonAsLeftNavbarButton];
    
    // Add BarButtonItems to the toolbar
    UIBarButtonItem *buttonCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                  target:self
                                                                  action:@selector(cancelButtonPressed:)];
    
    UIBarButtonItem *fixSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                              target:nil
                                                                              action:nil];
    fixSpace.width = 10.0;
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:nil];
    
    UIBarButtonItem *buttonNext = [[UIBarButtonItem alloc] initWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_NEXT")
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(nextButtonPressed:)];
    
    NSArray *arrayItems = [[NSArray alloc] initWithObjects:fixSpace, buttonCancel, flexSpace, buttonNext, fixSpace, nil];
    [self setToolbarItems:arrayItems];
    
    // Set screenshot image
    _imageScreenshot.image = self.submitData.screenshot;
    _imageScreenshot.userInteractionEnabled = YES;
    
    // Add a shadow to the screenshot
    _imageScreenshot.layer.shadowColor = [UIColor blackColor].CGColor;
    _imageScreenshot.layer.shadowOffset = CGSizeMake(0, 6);
    _imageScreenshot.layer.shadowOpacity = 0.6;
    _imageScreenshot.layer.shadowRadius = 12.0;
    _imageScreenshot.clipsToBounds = YES;
    
    // Setup semented control for the brush selection
    [_segmentedBrushes setSelectedSegmentIndex:BRUSH_2];
    _segmentedBrushes.hidden = YES;
    
    // Setup the description label
    _labelDescription.text = iPFTLocalizedString(@"iPFT_ANNOTATION_DESC");
    
    // Setup the touch event information overlay
    _viewTouchEvent.alpha = 0.0;
    _viewTouchEvent.userInteractionEnabled = NO;
    _labelTouchEvent.text = iPFTLocalizedString(@"iPFT_ANNOTATION_TOUCH_INFO");
    CGRect originalFrame = _labelTouchEvent.frame;
    [_labelTouchEvent sizeToFit];
    CGRect newFrame = _labelTouchEvent.frame;
    _labelTouchEvent.frame = CGRectMake(originalFrame.origin.x, newFrame.origin.y, originalFrame.size.width, newFrame.size.height);
    
    // Start animation
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(startInitialScreenshotAnimation) userInfo:nil repeats:NO];
}


- (void) startInitialScreenshotAnimation {

    // Get the screenshots and main views frame
    CGRect frame = _imageScreenshot.frame;
    CGRect mainframe = self.view.bounds;
    
    // Calculate the available space for the imageview
    float navbarHeight = self.navigationController.navigationBar.frame.size.height;
    float toolbarHeight = self.navigationController.toolbar.frame.size.height;
    double availableHeight = mainframe.size.height;
    availableHeight -= navbarHeight; // Navigationbar
    availableHeight -= toolbarHeight; // Top toolbar
    availableHeight -= toolbarHeight; // Bottom toolbar
    availableHeight -= SCREENSHOT_MARGIN; // Extra space (top and bottom margin) to have a nicer layout of the imageview
    
    // Calculate the aspect ratio of the image and resize it accordingly
    double aspect = frame.size.width / frame.size.height;
    frame.size.height = availableHeight;
    frame.size.width = frame.size.height * aspect;
    
    // Put the imageview into the correct position
    frame.origin.x = ( mainframe.size.width - frame.size.width ) / 2;
    frame.origin.y = 0; // Initial position
    frame.origin.y += navbarHeight; // Navigationbar
    frame.origin.y += toolbarHeight; // Top toolbar
    frame.origin.y += SCREENSHOT_MARGIN / 2; // The imageviews top margin
    
    // Animate the resize and repositioning of the screenshot imageview
    [UIView beginAnimations:@"initial screenshot animation" context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    [UIView setAnimationCurve:ANIMATION_CURVE];
    [_imageScreenshot setFrame:frame];
    _imageScreenshot.layer.borderWidth = 1.0;
    [UIView commitAnimations];
    
    // Let the navigationbar and toolbar appear
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    // Setup and add the paint view controller
    [self addPaintViewController:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    // Setup and add the annotation view controller
    [self addAnnotationViewController:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    // Show touch event information overlay
    [self showTouchEventOverlay];
}


- (void) addEditButtonAsLeftNavbarButton {
    
    // Initialize an edit button
    UIBarButtonItem *buttonEdit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleDrawing:)];
    
    // Add it to the navigation bar
    self.navigationItem.leftBarButtonItem = buttonEdit;
}


- (void) addDoneButtonAsLeftNavbarButton {
    
    // Initialize a done button
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toggleDrawing:)];
    
    // Add it to the navigation bar
    self.navigationItem.leftBarButtonItem = buttonDone;
}


- (void) showTouchEventOverlay {
    
    // Check if the info view has already been shown
    if ( [iPFTPersistence hasAnnotationInfoBeenShown] && !ALWAYS_SHOW_ANNOTATION_INFO_VIEW ) return;
    [iPFTPersistence setAnnotationInfoHasBeenShown];
    
    // Show the touch event information overlay view
    [UIView beginAnimations:@"hide touch event overlay" context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    [UIView setAnimationCurve:ANIMATION_CURVE];
    _viewTouchEvent.alpha = 1.0;
    [UIView commitAnimations];
    
    // Disable userinteraction for navigation bar and toolbar
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    self.navigationController.toolbar.userInteractionEnabled = NO;
    
    // Setup timer to hide the overlay view
    [NSTimer scheduledTimerWithTimeInterval:TOUCH_EVENT_INFORMATION_DURATION target:self selector:@selector(hideTouchEventOverlay) userInfo:nil repeats:NO];
}


- (void) hideTouchEventOverlay {
    
    // Hide the touch event information overlay view
    [UIView beginAnimations:@"hide touch event overlay" context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    [UIView setAnimationCurve:ANIMATION_CURVE];
    _viewTouchEvent.alpha = 0.0;
    [UIView commitAnimations];
    
    // Enable userinteraction for navigation bar and toolbar
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    self.navigationController.toolbar.userInteractionEnabled = YES;
}


- (void) toggleDrawing:(id)sender {
    
    // Toggle drawing status
    _isDrawing = !_isDrawing;
    
    // Setup the view accorrding to the new status
    if ( _isDrawing ) {
        
        // Add done button, hide the label and show the brush selection
        [self addDoneButtonAsLeftNavbarButton];
        _labelDescription.hidden = YES;
        _segmentedBrushes.hidden = NO;
        
        // Hide annotations
        _viewAnnotations.view.hidden = YES;
    }
    else {
     
        // Add the edit button, hide the brush selection and show the description label
        [self addEditButtonAsLeftNavbarButton];
        _labelDescription.hidden = NO;
        _segmentedBrushes.hidden = YES;

        // Show annotations
        _viewAnnotations.view.hidden = NO;
    }
}


- (void) addAnnotationViewController:(CGRect)frame {
    
    // Initialize and resize the annotation view controller
    _viewAnnotations = [[iPFTAnnotationViewController alloc] initWithNibName:@"iPFTAnnotationViewController" bundle:nil];
    [_viewAnnotations.view setFrame:frame];
    _viewAnnotations.submitData = self.submitData;
    
    // Add annotation view to the screenshot image
    [self addChildViewController:_viewAnnotations];
    [_imageScreenshot addSubview:_viewAnnotations.view];
    [_viewAnnotations didMoveToParentViewController:self];
}


- (void) addPaintViewController:(CGRect)frame {
    
    // Initialize and resize the paint view controller
    _viewPaint = [[iPFTPaintViewController alloc] initWithNibName:@"iPFTPaintViewController" bundle:nil];
    
    // Set brush size
    switch ( _segmentedBrushes.selectedSegmentIndex ) {
            
        case BRUSH_1:
            
            // Select smallest brush
            [_viewPaint setBrushSize:BRUSH_SIZE_1];
            break;
            
        case BRUSH_2:
            
            // Select middle sized brush
            [_viewPaint setBrushSize:BRUSH_SIZE_2];
            break;
            
        case BRUSH_3:
            
            // Select biggest brush
            [_viewPaint setBrushSize:BRUSH_SIZE_3];
            break;
            
        default:
            
            // Default should be the middle sized brush
            [_viewPaint setBrushSize:BRUSH_SIZE_2];
            break;
    }
    
    
    // Add paint view to the screenshot image
    [self addChildViewController:_viewPaint];
    [_imageScreenshot addSubview:_viewPaint.view];
    [_viewPaint didMoveToParentViewController:self];
}


#pragma mark - IBActions


- (IBAction) nextButtonPressed:(id)sender {
    
    // Leave drawing mode if active
    if ( _isDrawing ) [self toggleDrawing:sender];

    // Hide annotations detail view if visible
    [_viewAnnotations hideAnnotationDetails:NO];
    
    // Create an annotated screnshot
    [self.submitData fetchAnnotatedScreenshot:_imageScreenshot];
    
    // Initialize message view and push it
    iPFTMessageViewController *viewMessage = [[iPFTMessageViewController alloc] initWithNibName:@"iPFTMessageViewController" bundle:nil];
    viewMessage.submitData = self.submitData;
    [self.navigationController pushViewController:viewMessage animated:YES];
}


- (IBAction) cancelButtonPressed:(id)sender {
 
    // Enable processing of further shake gestures
    [iPFTPersistence setBlockShakeGesture:NO];
    
    // Call super class method
    [super cancelButtonPressed:sender];
}


- (IBAction) segmentedBrushChanged:(id)sender {
    
    // Update brush size or enter eraser mode
    switch ( _segmentedBrushes.selectedSegmentIndex ) {
        
        case BRUSH_1:
            
            // Update brush to smallest size
            [_viewPaint setBrushSize:BRUSH_SIZE_1];
            break;
            
        case BRUSH_2:
            
            // Update brush to middle size
            [_viewPaint setBrushSize:BRUSH_SIZE_2];
            break;
            
        case BRUSH_3:
            
            // Update brush to biggest size
            [_viewPaint setBrushSize:BRUSH_SIZE_3];
            break;
            
        case ERASER:
            
            // Enter eraser mode
            [_viewPaint setEraserActive];
            break;
            
        default:
            
            // Default points to middle sized brush
            [_viewPaint setBrushSize:BRUSH_SIZE_2];
            break;
    }
}


@end
