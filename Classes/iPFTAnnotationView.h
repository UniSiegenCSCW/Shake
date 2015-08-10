//
//  iPFTAnnotationView.h
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

/**
	Delegate for the annotation view
 */
@protocol AnnotationDelegate <NSObject>

@optional

/**
	Tell the delegate that an annotation has been tapped
	@param sender This annotation
 */
- (void) tappedAnnotation:(id)sender;

@end

/**
	Class for a single annotation
 */
@interface iPFTAnnotationView : UIView <UIGestureRecognizerDelegate>

#pragma mark - Properties

@property (nonatomic, assign) id<AnnotationDelegate> delegate; /**< AnnotationView delegate */
@property (nonatomic, strong) NSString *details; /**< The annotations detail text */
@property (nonatomic, strong) NSNumber *uniqueID; /**< The unique ID for the annotation given by the management class */
@property (nonatomic, strong) UIImageView *imageAnnotation; /**< Imageview for the annotation image */
@property (nonatomic, strong) UILabel *labelID; /**< Label for the unique ID */

#pragma mark - Initialization

/**
	Init a new annotation at a given position (point of long tap)
	@param position CGPoint position of long tap
	@returns self
 */
- (id) initWithPosition:(CGPoint)position;

#pragma mark - Instance Methods

/**
	General configuration for an annotation
 */
- (void) initData;

/**
	Adds this views gesture recognizers
 */
- (void) addGestureRecognizers;

/**
	Gets called when a tap gesture was detected
    @param recognizer The event trigger of type UITapGestureRecognizer
 */
- (void) tapGestureDetected:(UITapGestureRecognizer *)recognizer;

/**
	Gets called when a pan gesture was detected
    @param recognizer The event trigger of type UIPanGestureRecognizer
 */
- (void) panGestureDetected:(UIPanGestureRecognizer *)recognizer;

@end
