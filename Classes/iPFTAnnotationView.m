//
//  iPFTAnnotationView.m
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

#import "iPFTAnnotationView.h"

@implementation iPFTAnnotationView


@synthesize imageAnnotation = _imageAnnotation;
@synthesize uniqueID = _uniqueID;
@synthesize details = _details;
@synthesize delegate = _delegate;
@synthesize labelID = _labelID;


#pragma mark - Iniitalization


- (id) initWithPosition:(CGPoint)position {
    
    self = [super init];
    if ( self ) {
        
        // Build the view
        _imageAnnotation = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 25, 25)];
        _imageAnnotation.image = [UIImage imageNamed:@"iPhoneFeedbackTool.bundle/iPFT_Annotation"];
        CGRect frame = CGRectMake(position.x - ( _imageAnnotation.frame.size.width / 2 ) - 5,
                                  position.y - ( _imageAnnotation.frame.size.height / 2 ) - 5,
                                  _imageAnnotation.frame.size.width + 10,
                                  _imageAnnotation.frame.size.height + 10);
        [self setFrame:frame];
        [self addSubview:_imageAnnotation];
        
        // Build the ID label
        _labelID = [[UILabel alloc] initWithFrame:_imageAnnotation.frame];
        _labelID.textAlignment = NSTextAlignmentCenter;
        _labelID.textColor = [UIColor whiteColor];
        _labelID.font = [UIFont boldSystemFontOfSize:17.0];
        [self addSubview:_labelID];
        
        // Initialize the view
        [self initData];
    }
    return self;
}


#pragma mark - Instance methods

- (void) initData {
    
    // Add this views gesture recognizers
    [self addGestureRecognizers];
}


- (void) addGestureRecognizers {
    
    // Create and config the pan gesture
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
    [panGestureRecognizer setDelegate:self];
    [self addGestureRecognizer:panGestureRecognizer];
    
    // create and config the tap gesture
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureDetected:)];
    [tapGestureRecognizer setDelegate:self];
    [self addGestureRecognizer:tapGestureRecognizer];
}


- (void) tapGestureDetected:(UITapGestureRecognizer *)recognizer {
    
    if ( _delegate && [_delegate respondsToSelector:@selector(tappedAnnotation:)] ) {
        
        [_delegate tappedAnnotation:self];
    }
}


- (void) panGestureDetected:(UIPanGestureRecognizer *)recognizer {
    
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
}


#pragma mark - Setters


- (void) setUniqueID:(NSNumber *)uniqueID {
    
    _uniqueID = uniqueID;
    _labelID.text = [NSString stringWithFormat:@"%i",[uniqueID intValue]];
}


@end
