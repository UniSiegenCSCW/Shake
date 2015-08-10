//
//  iPFTPaintViewController.h
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

#define BRUSH_SIZE_1 10.0 /**< Defines the brush size for the smallest brush */
#define BRUSH_SIZE_2 15.0 /**< Defines the brush size for the middle sized brush */
#define BRUSH_SIZE_3 20.0 /**< Defines the brush size for the biggest brush */
#define ERASER_SIZE 20.0 /**< Defines the eraser size */

/**
	ViewController for the drawing
 */
@interface iPFTPaintViewController : UIViewController {
    
    CGPoint _lastPoint; /**< Last drawn point on the canvas */
    CGFloat _r; /**< Drawing RGB red value */
    CGFloat _g; /**< Drawing RGB green value */
    CGFloat _b; /**< Drawing RGB blue value */
    CGFloat _brush; /**< Brush stroke width */
    CGFloat _opacity; /**< Drawing opacity value */
    BOOL _swiped; /**< True, if the brush stroke is continuous */
    BOOL _erase; /**< True, if the eraser is currently selected */
}

#pragma mark - Properties

@property (nonatomic, weak) IBOutlet UIImageView *drawImage; /**< UIImageView for the drawing part */

#pragma mark - Instance Methods

/**
	General setup for this view controller
 */
- (void) initData;

/**
	Sets the brush size
	@param brushSize Brush size as float
 */
- (void) setBrushSize:(float)brushSize;

/**
	Activates the eraser
 */
- (void) setEraserActive;

#pragma mark - IBActions

@end
