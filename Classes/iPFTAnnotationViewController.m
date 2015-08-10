//
//  iPFTAnnotationViewController.m
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

#import "iPFTAnnotationViewController.h"


@implementation iPFTAnnotationViewController


@synthesize viewDetails = _viewDetails;
@synthesize textDetails = _textDetails;
@synthesize labelDetailsPlaceholder = _labelDetailsPlaceholder;
@synthesize buttonDelete = _buttonDelete;
@synthesize buttonDone = _buttonDone;
@synthesize labelAnnotationTitle = _labelAnnotationTitle;


#pragma mark - View Lifecycle


- (void)viewDidLoad {
    
    // Call the super class
    [super viewDidLoad];
    
    // Do the initial setup of this view
    [self initData];
}


- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Save details views X
    _originalX = _viewDetails.frame.origin.x;
    
    // Calculate offsets
    _position0 = -1 * ( _viewDetails.frame.size.height + 10 );
    _position1 = 10;
    _position2 = self.view.frame.size.height - 10 - _viewDetails.frame.size.height;
    
    // Initially hide detail views
    [self moveDetailView:_position0 animated:NO];
}


#pragma mark - Instance Methods


- (void) initData {
    
    // Setup detail view
    _viewDetails.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    // Setup the button titles
    [_buttonDelete setTitle:iPFTLocalizedString(@"iPFT_BUTTON_DELETE") forState:UIControlStateNormal];
    [_buttonDone setTitle:iPFTLocalizedString(@"iPFT_BUTTON_DONE") forState:UIControlStateNormal];
    
    // Setup and add ths views gesture recognizers
    [self addGestureRecognizers];
    
    // Subviews need to stay inside this view
    self.view.clipsToBounds = YES;
    
    // Add observers to get keyboards status information
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    // Create placeholder for the details textview
    _labelDetailsPlaceholder.text = iPFTLocalizedString(@"iPFT_ANNOTATION_PLACEHOLDER");
}


- (void) dealloc {
    
    // Remove observers
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void) keyboardWillShow {
    
    // Move detail view up to keep it in the visible area
    [self moveDetailView:_position1 animated:YES];
}


- (void) keyboardWillHide {
    
    // Move detail view to its original position
    [self displayAnnotationDetails];
}


- (void) addGestureRecognizers {
    
    // Create and configure the long press gesture
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(addAnnotationGestureDetected:)];
    longPressGestureRecognizer.minimumPressDuration = LONG_PRESS_DURATION;
    [longPressGestureRecognizer setDelegate:self];
    [self.view addGestureRecognizer:longPressGestureRecognizer];
    
    // Create and add double tap gesture recognizer
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(addAnnotationGestureDetected:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    // Create and config the pan gesture
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
    [panGestureRecognizer setDelegate:self];
    [self.viewDetails addGestureRecognizer:panGestureRecognizer];
}


- (void) moveDetailView:(float)positionY animated:(BOOL)animated {
    
    // Get current frame and calculate new one
    CGRect frame = _viewDetails.frame;
    CGRect newFrame = CGRectMake(_originalX,
                                 positionY,
                                 frame.size.width,
                                 frame.size.height);
    
    // Animate the view to its desired position
    if ( animated ) {
       
        [UIView beginAnimations:@"move view" context:nil];
        [UIView setAnimationDuration:ANIMATION_DURATION];
        [UIView setAnimationCurve:ANIMATION_CURVE];
        [_viewDetails setFrame:newFrame];
        [UIView commitAnimations];
    }
    
    // Move view without any animation
    else {
        
        [_viewDetails setFrame:newFrame];
    }
}


- (void) panGestureDetected:(UIPanGestureRecognizer *)recognizer {
    
    // Retrieve current gesture recognizer state
    UIGestureRecognizerState state = [recognizer state];
    
    if ( state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged ) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
}


- (void) addAnnotationGestureDetected:(UIGestureRecognizer *)recognizer {
    
    // Retrieve current gesture recognizer state
    UIGestureRecognizerState state = [recognizer state];
    
    // Only take any action when the gesture ended
    if ( state == UIGestureRecognizerStateEnded ) {
        
        // Get current tap position
        CGPoint position = [recognizer locationInView:self.view];
        
        // Add new annotation at this position
        [self addNewAnnotationAtPosition:position];
    }
}


- (void) addNewAnnotationAtPosition:(CGPoint)position {
    
    // Check if we already have reached the max number of annotations
    if ( self.submitData.arrayAnnotations.count >= MAX_ANNOTATIONS ) {
        
        // Inform the user about the limit and exit
        [self alertMaxAnnotationsReached];
        return;
    }
    
    // Create and add the annotation
    iPFTAnnotationView *annotation = [[iPFTAnnotationView alloc] initWithPosition:position];
    annotation.delegate = self;
    [self.view addSubview:annotation];
    [self.view bringSubviewToFront:_viewDetails];
    
    // Add annotation to the submit data
    [self.submitData.arrayAnnotations addObject:annotation];
    NSNumber *index = [NSNumber numberWithInt:(int)[self.submitData.arrayAnnotations indexOfObject:annotation]+1];
    [annotation setUniqueID:index];
    
    // Make the new annotation active and display the details
    _activeAnnotation = annotation;
    [self displayAnnotationDetails];
}


- (void) alertMaxAnnotationsReached {
    
    // Create an alert view to inform the user about the anotation limit
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:iPFTLocalizedString(@"iPFT_ALERT_MAX_ANNOTATIONS_TITLE")
                                          message:[NSString stringWithFormat:iPFTLocalizedString(@"iPFT_ALERT_MAX_ANNOTATIONS_MSG"),MAX_ANNOTATIONS]
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    // Add actions to the alert view
    UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_OK")
                                   style:UIAlertActionStyleCancel
                                   handler:nil];
    
    [alertController addAction:okAction];
    
    // Present alert view
    [self.parentViewController presentViewController:alertController animated:YES completion:nil];
}


- (void) deleteAnnotation:(iPFTAnnotationView *)annotation {
    
    // Remove the annotation from the superview
    [annotation removeFromSuperview];
    
    // Remove annotation from submit data
    [self.submitData.arrayAnnotations removeObject:annotation];
    
    // Update annotation IDs
    for ( iPFTAnnotationView *anno in self.submitData.arrayAnnotations ) {
        
        NSNumber *index = [NSNumber numberWithInt:(int)[self.submitData.arrayAnnotations indexOfObject:anno]+1];
        [anno setUniqueID:index];
    }
}


- (void) displayAnnotationDetails {
    
    // Check if there is an active annotation
    if ( !_activeAnnotation ) return;
    
    // Find out where to display the details (top or bottom area)
    float activeOriginY = _activeAnnotation.frame.origin.y;
    //float height = ( self.view.frame.size.height / 2 ) - ( _activeAnnotation.frame.size.height / 2 );
    float height = _viewDetails.frame.size.height + 10;

    // Fill the detail view with text
    _textDetails.text = _activeAnnotation.details;
    _labelDetailsPlaceholder.hidden = YES;
    if ( [_textDetails.text isEqualToString:@""] ) _labelDetailsPlaceholder.hidden = NO;
    _labelAnnotationTitle.text =  [NSString stringWithFormat:iPFTLocalizedString(@"iPFT_ANNOTATION_TITLE"),[_activeAnnotation.uniqueID intValue]];
    
    // Display the detail view in the top area
    if ( activeOriginY >= height ) {
     
        [self moveDetailView:_position1 animated:YES];
    }
    
    // Display the detail view in the bottom area
    else {
        
        [self moveDetailView:_position2 animated:YES];
    }
}


- (void) hideAnnotationDetails:(BOOL)animated {
    
    // Check if thre is an active annotation
    if ( !_activeAnnotation ) return;
    
    // Hide detail views
    [_textDetails resignFirstResponder];
    [self moveDetailView:_position0 animated:animated];
    
    // Clear the active annotation
    _activeAnnotation = nil;
}


- (void) alertConfirmDelete {
    
    // Reference to self used in blocks
    __weak id weakSelf = self;
    
    // Create an alert view that asks the user for confirmation
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:iPFTLocalizedString(@"iPFT_ALERT_CONFIRM_DELETE_TITLE")
                                          message:iPFTLocalizedString(@"iPFT_ALERT_CONFIRM_DELETE_MSG")
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    // Add actions to the alert view
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_NO")
                                   style:UIAlertActionStyleCancel
                                   handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_YES")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   // Delete the current annotation
                                   [weakSelf deleteAnnotation:_activeAnnotation];
                                   
                                   // Hide the detail view
                                   [weakSelf hideAnnotationDetails:YES];
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    // Present alert view
    [self.parentViewController presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Annotation delegate


- (void) tappedAnnotation:(id)sender {
    
    // Check if we really deal with an annotation view
    if ( ![sender isKindOfClass:[iPFTAnnotationView class]] ) return;
    
    // Check if we have to display or hide the annotationdetail view
    if ( _activeAnnotation == (iPFTAnnotationView *)sender ) {
        
        // Hide detail view
        [self hideAnnotationDetails:YES];
        return;
    }
    
    // Resign first responder, just in case one annotation is still in editing mode
    [_textDetails resignFirstResponder];
    
    // Cast the sender object and display the details
    iPFTAnnotationView *annotation = (iPFTAnnotationView *)sender;
    _activeAnnotation = annotation;
    [self displayAnnotationDetails];
}


#pragma mark - UITextView delegate


- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    // Hide placeholder while editing
    _labelDetailsPlaceholder.hidden = YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    // Check if there is an acitve annotation
    if ( !_activeAnnotation ) return;
    
    // Write changes to the annotation
    _activeAnnotation.details = textView.text;
    
    // Show placeholder if needed
    if ( [textView.text isEqualToString:@""] ) {
        
        _labelDetailsPlaceholder.hidden = NO;
    }
    else {
        
        _labelDetailsPlaceholder.hidden = NO;
    }
}


#pragma mark - IBActions


- (IBAction) buttonDonePressed:(id)sender {

    // Save changes and hide the annotation details
    [self hideAnnotationDetails:YES];
}


- (IBAction) buttonDeletePressed:(id)sender {
    
    // Ask the user for confirmation
    [self alertConfirmDelete];
}


@end
