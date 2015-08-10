//
//  iPFTAnnotationViewController.h
//  iPhoneFeedbackTool
//
//  Created by Christian Neumann on 04.07.15.
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

#import <UIKit/UIKit.h>
#import "iPFTAnnotationView.h"
#import "iPFTSubmitData.h"

#define ANIMATION_DURATION 0.25 /**< Animation duration for the display view animation */
#define ANIMATION_CURVE 7.0 /**< Animation curve for the display view animation */
#define MAX_ANNOTATIONS 9 /**< Allow no more than 9 annotations */
#define LONG_PRESS_DURATION 0.5 /**< Minimum press duration for a long press to be detected */

/**
	Management view controller for the annotations
 */
@interface iPFTAnnotationViewController : UIViewController <AnnotationDelegate, UITextViewDelegate, UIGestureRecognizerDelegate> {
    
    iPFTAnnotationView *_activeAnnotation; /**< Active annotation that is currently being created/edited */
    float _originalX; /**< X of the detail view fpr all positions */
    float _position0; /**< Position that shows the detail view out of the view */
    float _position1; /**< Position that shows the detail view in top area */
    float _position2; /**< Position that shows the detail view in bottom area */
}

#pragma mark - Properties

@property (nonatomic, strong) iPFTSubmitData *submitData; /**< This propety contains all data for feedback submission */
@property (nonatomic, weak) IBOutlet UIView *viewDetails; /**< View for the annotation details */
@property (nonatomic, weak) IBOutlet UITextView *textDetails; /**< Textview for the detail view */
@property (nonatomic, weak) IBOutlet UILabel *labelDetailsPlaceholder; /**< Placeholder for the detail views textview */
@property (nonatomic, weak) IBOutlet UIButton *buttonDelete; /**< Delete button for the detail view */
@property (nonatomic, weak) IBOutlet UIButton *buttonDone; /**< Done button for the detail view */
@property (nonatomic, weak) IBOutlet UILabel *labelAnnotationTitle; /**< Label to display the currently selected annotation */

#pragma mark - Instance Methods

/**
	General settings for the view controller
 */
- (void) initData;

/**
	Called when the keyboard will show notification was received
 */
- (void) keyboardWillShow;

/**
	Called when the keyboard will hide notification was received
 */
- (void) keyboardWillHide;

/**
	Adds this views gesture recognizers
 */
- (void) addGestureRecognizers;

/**
	Moves the detail view on the y-axis
	@param positionY The desired position on the y-axis
    @param animated Animation flag
 */
- (void) moveDetailView:(float)positionY animated:(BOOL)animated;

/**
	Opens the annotation views details
 */
- (void) displayAnnotationDetails;

/**
	Hides the annotation views details;
    @param animated Animation flag
 */
- (void) hideAnnotationDetails:(BOOL)animated;

/**
	Pan gesture detected
	@param recognizer UIPangestureRecognizer
 */
- (void) panGestureDetected:(UIPanGestureRecognizer *)recognizer;

/**
	Double tap gesture detected
	@param sender The gesture recognizer
 */
- (void) addAnnotationGestureDetected:(UIGestureRecognizer *)gestureRecognizer;

/**
	Add new annotation at this position
	@param position CGPoint of long tap
 */
- (void) addNewAnnotationAtPosition:(CGPoint)position;

/**
	Inform the user about the annotation limit
 */
- (void) alertMaxAnnotationsReached;

/**
	Removes an annotation from the array
	@param annotation Annotation to delete
 */
- (void) deleteAnnotation:(iPFTAnnotationView *)annotation;

/**
	Asks the user for confirmation for the delete operation
 */
- (void) alertConfirmDelete;

#pragma mark - IBActions

/**
	Gets called when the done button was pressed
	@param sender The event trigger
	@returns IBAction
 */
- (IBAction) buttonDonePressed:(id)sender;

/**
	Gets called when the delete button was pressed
	@param sender The event trigger
	@returns IBAction
 */
- (IBAction) buttonDeletePressed:(id)sender;

@end
