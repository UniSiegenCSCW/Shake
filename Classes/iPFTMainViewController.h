//
//  iPFTMainViewController.h
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
#import "iPFTMessageViewController.h"
#import "iPFTAnnotationViewController.h"
#import "iPFTPaintViewController.h"

#define BRUSH_1 0 /**< Segment index for the smallest brush */
#define BRUSH_2 1 /**< Segment index for the middle size brush */
#define BRUSH_3 2 /**< Segment index for the biggest brush */
#define ERASER 3 /**< Segment index for the eraser */

#define ANIMATION_DURATION 0.25 /**< Animation duration for the moving imageview animation */
#define ANIMATION_CURVE 7.0 /**< Animation curve for the moving imageview animation */
#define SCREENSHOT_MARGIN 20.0 /**< Extra space to have a nicer layout of the screenshot imageview within the container */

#define TOUCH_EVENT_INFORMATION_DURATION 7.0 /**< Display duration for the touch event information overlay */

/**
	Entry point for the feedback tool
 */
@interface iPFTMainViewController : iPFTBaseViewController {
    
    BOOL _isDrawing; /**< Flag that stores information about the current drawing status of the view controller (enabled / disabled) */
}

#pragma mark - Properties

@property (nonatomic, weak) IBOutlet UIImageView *imageScreenshot; /**< Imageview for the screenshot */
@property (nonatomic, strong) iPFTAnnotationViewController *viewAnnotations; /**< View controller for the annotations */
@property (nonatomic, strong) iPFTPaintViewController *viewPaint; /**< View controller for the drawings */
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedBrushes; /**< SegmentedControl that is used to select a brush size or eraser tool */
@property (nonatomic, weak) IBOutlet UILabel *labelDescription; /**< Description label for this view */
@property (nonatomic, weak) IBOutlet UIView *viewTouchEvent; /**< Overlay view for the touch event information */
@property (nonatomic, weak) IBOutlet UILabel *labelTouchEvent; /**< Label for the touch event information overlay view */

#pragma mark - Instance methods

/**
	Animates the captured screenshot and moves it into position
 */
- (void) startInitialScreenshotAnimation;

/**
	Adds an edit button to enable drawing
 */
- (void) addEditButtonAsLeftNavbarButton;

/**
	Adds a done button to disable drawing
 */
- (void) addDoneButtonAsLeftNavbarButton;

/**
	Shows the touch event information overlay view
 */
- (void) showTouchEventOverlay;

/**
	Hides the touch event information overlay view after a period of time
 */
- (void) hideTouchEventOverlay;

/**
	Toggle drawing mode (enable / disable) depending on current status
    @param sender The event triggering button
 */
- (void) toggleDrawing:(id)sender;

/**
	Setup and add the annotation view controller
    @param frame The frame of the resized screenshot image
 */
- (void) addAnnotationViewController:(CGRect)frame;

/**
	Setup and add the paint view controller
    @param frame The frame of the resized screenshot image
 */
- (void) addPaintViewController:(CGRect)frame;

#pragma mark - IBActions

/**
	Gets called when the segmented control selects another brush or eraser tool
	@param sender The event trigger
	@returns IBAction
 */
- (IBAction) segmentedBrushChanged:(id)sender;

@end
