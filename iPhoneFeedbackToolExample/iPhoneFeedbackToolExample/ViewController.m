//
//  ViewController.m
//  iPhoneFeedbackToolExample
//
//  Created by Christian Neumann on 30.05.15.
//  Copyright (c) 2015 Universität Siegen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize viewWeb;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"UIWebView initialized");
    NSString *requestString = @"http://www.apple.com";
    NSLog(@"UIWebView loadingRequest: %@", requestString);
    
    [viewWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestString]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
