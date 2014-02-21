//
//  MenuViewController.m
//  ChouTi
//
//  Created by administrator on 13-11-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

#define kMenuFullWidth 320.0f
#define kMenuDisplayedWidth 280.0f
#define kMenuOverlayWidth (self.view.bounds.size.width - kMenuDisplayedWidth)
#define kMenuBounceOffset 10.0f
#define kMenuBounceDuration .3f
#define kMenuSlideDuration .3f

//@interface MenuViewController (Internal)
//- (void)showShadow:(BOOL)val;
//@end

@implementation MenuViewController
@synthesize delegate;
@synthesize leftViewController,rightViewController,rootViewController;
@synthesize click,gesture;

- (id)initWithRootViewController:(UIViewController*)controller {
    if ((self = [super init])) {
        rootViewController = controller;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [self setRootViewController:rootViewController];
    if (!click) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.delegate = (id<UIGestureRecognizerDelegate>)self;
        [self.view addGestureRecognizer:tap];
        [tap setEnabled:NO];
        click = tap;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    click = nil;
    gesture = nil;
}

//toInterfaceOrientation可以，自带的InterfaceOrientation不可以

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    // Return YES for supported orientations
    return [rootViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    if (rootViewController) {
        [rootViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
        UIView *view = rootViewController.view;
        if (_menuFlags.showingRightView) {
             view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        }else if (_menuFlags.showingLeftView) {
            view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        }else{
            view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        }
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    if (rootViewController) {
        [rootViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
        CGRect frame = self.view.bounds;
        if (_menuFlags.showingLeftView) {
            frame.origin.x = frame.size.width - kMenuOverlayWidth;
        }else if (_menuFlags.showingRightView) {
            frame.origin.x = frame.size.width - kMenuOverlayWidth;
        } 
        rootViewController.view.frame = frame;
        rootViewController.view.autoresizingMask = self.view.autoresizingMask;
      // [self showShadow:(rootViewController.view.layer.shadowOpacity!=0.0f)];
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    if (rootViewController) {
        [rootViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

#pragma mark - GestureRecognizers

- (void)gesture:(UIPanGestureRecognizer*)Gesture {
    if(Gesture.state == UIGestureRecognizerStateBegan) {
        //[self showShadow:YES];
        gestureOriginX = self.view.frame.origin.x;        
        gestureVelocity = CGPointMake(0.0f, 0.0f);
        if([gesture velocityInView:self.view].x > 0) {
            GesDirection = GesDirectionRight;
        }else{
            GesDirection = GesDirectionLeft;
        }
    }
    if(Gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint velocity = [gesture velocityInView:self.view];
        if((velocity.x * gestureVelocity.x + velocity.y * gestureVelocity.y) < 0) {
            GesDirection = (GesDirection == GesDirectionRight) ? GesDirectionLeft : GesDirectionRight;
        }
        gestureVelocity = velocity;        
        CGPoint translation = [gesture translationInView:self.view];
        CGRect frame = rootViewController.view.frame;
        frame.origin.x = gestureOriginX + translation.x;
        if(frame.origin.x > 0.0f && !_menuFlags.showingLeftView) {
            if(_menuFlags.showingRightView) {
                _menuFlags.showingRightView = NO;
                [self.rightViewController.view removeFromSuperview];
            }
            if (_menuFlags.canShowLeft) {
                
                _menuFlags.showingLeftView = YES;
                CGRect frame = self.view.bounds;
				frame.size.width = kMenuFullWidth;
                self.leftViewController.view.frame = frame;
                [self.view insertSubview:self.leftViewController.view atIndex:0];
            }else{
                frame.origin.x = 0.0f; // ignore right view if it's not set
            }
         }else if(frame.origin.x < 0.0f && !_menuFlags.showingRightView) {
            if(_menuFlags.showingLeftView) {
                _menuFlags.showingLeftView = NO;
                [self.leftViewController.view removeFromSuperview];
            }
            if (_menuFlags.canShowRight) {
                _menuFlags.showingRightView = YES;
                CGRect frame = self.view.bounds;
				frame.origin.x += frame.size.width - kMenuFullWidth;
				frame.size.width = kMenuFullWidth;
                self.rightViewController.view.frame = frame;
                [self.view insertSubview:self.rightViewController.view atIndex:0];
            }else{
                frame.origin.x = 0.0f; // ignore left view if it's not set
            }
        }
        rootViewController.view.frame = frame;
    }else if(Gesture.state == UIGestureRecognizerStateEnded || Gesture.state == UIGestureRecognizerStateCancelled) {
        //  Finishing moving to left, right or root view with current pan velocity
        [self.view setUserInteractionEnabled:NO];
        PanCompletion completion = GesCompletionRoot; // by default animate back to the root
        if (GesDirection == GesDirectionRight && _menuFlags.showingLeftView) {
            completion = GesCompletionLeft;
        }else if(GesDirection == GesCompletionLeft && _menuFlags.showingRightView) {
            completion = GesCompletionRight;
        }
        CGPoint velocity = [gesture velocityInView:self.view];    
        if (velocity.x < 0.0f) {
            velocity.x *= -1.0f;
        }
        BOOL bounce = (velocity.x > 800);
        CGFloat originX = rootViewController.view.frame.origin.x;
        CGFloat width = rootViewController.view.frame.size.width;
        CGFloat span = (width - kMenuOverlayWidth);
        CGFloat duration = kMenuSlideDuration; // default duration with 0 velocity
        if(bounce){
            duration = (span / velocity.x); // bouncing we'll use the current velocity to determine duration
        }else{
            duration = ((span - originX) / span) * duration; // user just moved a little, use the defult duration, otherwise it would be too slow
        }
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            if (completion == GesCompletionLeft) {
                [self showLeftController:NO];
            } else if (completion == GesCompletionRight) {
                [self showRightController:NO];
            } else {
                [self showRootController:NO];
            }
            [rootViewController.view.layer removeAllAnimations];
            [self.view setUserInteractionEnabled:YES];
        }];
        CGPoint pos = rootViewController.view.layer.position;
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        
        NSMutableArray *keyTimes = [[NSMutableArray alloc] initWithCapacity:bounce ? 3 : 2];
        NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:bounce ? 3 : 2];
        NSMutableArray *timingFunctions = [[NSMutableArray alloc] initWithCapacity:bounce ? 3 : 2];
        
        [values addObject:[NSValue valueWithCGPoint:pos]];
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [keyTimes addObject:[NSNumber numberWithFloat:0.0f]];
        if (bounce) {
            duration += kMenuBounceDuration;
            [keyTimes addObject:[NSNumber numberWithFloat:1.0f - ( kMenuBounceDuration / duration)]];
            if (completion == GesCompletionLeft) {
                [values addObject:[NSValue valueWithCGPoint:CGPointMake(((width/2) + span) + kMenuBounceOffset, pos.y)]];
            } else if (completion == GesCompletionRight) {
                
                [values addObject:[NSValue valueWithCGPoint:CGPointMake(-((width/2) - (kMenuOverlayWidth-kMenuBounceOffset)), pos.y)]];
            } 
            else {
                // depending on which way we're panning add a bounce offset
                if (GesDirection == GesCompletionLeft) {
                    [values addObject:[NSValue valueWithCGPoint:CGPointMake((width/2) - kMenuBounceOffset, pos.y)]];
                }
                else {
                    [values addObject:[NSValue valueWithCGPoint:CGPointMake((width/2) + kMenuBounceOffset, pos.y)]];
                }
            }
            
            [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        }
        if (completion == GesCompletionLeft) {
            [values addObject:[NSValue valueWithCGPoint:CGPointMake((width/2) + span, pos.y)]];
        } else if (completion == GesCompletionRight) {
            [values addObject:[NSValue valueWithCGPoint:CGPointMake(-((width/2) - kMenuOverlayWidth), pos.y)]];
        } else {
            [values addObject:[NSValue valueWithCGPoint:CGPointMake(width/2, pos.y)]];
        }
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [keyTimes addObject:[NSNumber numberWithFloat:1.0f]];
        
        animation.timingFunctions = timingFunctions;
        animation.keyTimes = keyTimes;
        //animation.calculationMode = @"cubic";
        animation.values = values;
        animation.duration = duration;   
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [rootViewController.view.layer addAnimation:animation forKey:nil];
        [CATransaction commit];
        
        [keyTimes release];
        [values release];
        [timingFunctions release];
    }    
}

- (void)tap:(UITapGestureRecognizer*)Gesture {
    
    [Gesture setEnabled:NO];
    [self showRootController:YES];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // Check for horizontal pan gesture
    if (gestureRecognizer == gesture) {
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint translation = [panGesture translationInView:self.view];
        
        if ([panGesture velocityInView:self.view].x < 600 && sqrt(translation.x * translation.x) / sqrt(translation.y * translation.y) > 1) {
            return YES;
        } 
        return NO;
    }
    if (gestureRecognizer == click) {
        if (rootViewController && (_menuFlags.showingRightView || _menuFlags.showingLeftView)) {
            return CGRectContainsPoint(rootViewController.view.frame, [gestureRecognizer locationInView:self.view]);
        }
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer==click) {
        return YES;
    }     
    return NO;
}

#pragma Internal Nav Handling 

- (void)resetNavButtons {
    if (!rootViewController) return;
    UIViewController *topController = nil;
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController*)rootViewController;
        if ([[navController viewControllers] count] > 0) {
            topController = [[navController viewControllers] objectAtIndex:0];
        }
    } else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tabController = (UITabBarController*)rootViewController;
        topController = [tabController selectedViewController];
    } else {
        
        topController = rootViewController;
    }
	//页面菜单
    if (_menuFlags.canShowLeft) {
//        topController.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(showLeft:)]autorelease];
//        
       
        
         UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0,0,30,30)];
        [button setImage:[UIImage imageNamed:@"nav_menu_icon.png"] forState:UIControlStateNormal];
         //[button setBackgroundImage:[UIImage imageNamed:@"nav_menu_icon.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
         UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:button];
       
         topController.navigationItem.leftBarButtonItem  = btn;
                
        
    } else {
        topController.navigationItem.leftBarButtonItem = nil;
    }
    if (_menuFlags.canShowRight) {
        topController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon.png"] style:UIBarButtonItemStyleBordered  target:self action:@selector(showRight:)]autorelease];
    } else {
        topController.navigationItem.rightBarButtonItem = nil;
    }
}


- (void)showRootController:(BOOL)animated {
    [click setEnabled:YES];
    rootViewController.view.userInteractionEnabled = YES;
    
    CGRect frame = rootViewController.view.frame;
    frame.origin.x = 0.0f;
    
    BOOL _enabled = [UIView areAnimationsEnabled];
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    
    [UIView animateWithDuration:.3 animations:^{
        rootViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        if (leftViewController && leftViewController.view.superview) {
            [leftViewController.view removeFromSuperview];
        }
        if (rightViewController && rightViewController.view.superview) {
            [rightViewController.view removeFromSuperview];
        }
        _menuFlags.showingLeftView = NO;
        _menuFlags.showingRightView = NO;
        
       //[self showShadow:NO];
    }];
    if (!animated) {
        [UIView setAnimationsEnabled:_enabled];
    }
}

- (void)showLeftController:(BOOL)animated {
    if (!_menuFlags.canShowLeft) return;
    if (rightViewController && rightViewController.view.superview) {
        [rightViewController.view removeFromSuperview];
        _menuFlags.showingRightView = NO;
    }
    if (_menuFlags.respondsToWillShowViewController) {
        [self.delegate menuController:self willShowViewController:self.leftViewController];
    }
    _menuFlags.showingLeftView = YES;
   //[self showShadow:YES];

    UIView *view = self.leftViewController.view;
	CGRect frame = self.view.bounds;
	frame.size.width = kMenuFullWidth;
    view.frame = frame;
    [self.view insertSubview:view atIndex:0];
    [self.leftViewController viewWillAppear:animated];
    
    frame = rootViewController.view.frame;
    frame.origin.x = CGRectGetMaxX(view.frame) - (kMenuFullWidth - kMenuDisplayedWidth);
    
    BOOL _enabled = [UIView areAnimationsEnabled];
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    
    rootViewController.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:.3 animations:^{
        rootViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        [click setEnabled:YES];
    }];
    
    if (!animated) {
        [UIView setAnimationsEnabled:_enabled];
    }
}

- (void)showRightController:(BOOL)animated {
    if (!_menuFlags.canShowRight) return;
    
    if (leftViewController && leftViewController.view.superview) {
        [leftViewController.view removeFromSuperview];
        _menuFlags.showingLeftView = NO;
    }
    
    if (_menuFlags.respondsToWillShowViewController) {
        [self.delegate menuController:self willShowViewController:self.rightViewController];
    }
    _menuFlags.showingRightView = YES;
    //[self showShadow:YES];
    
    UIView *view = self.rightViewController.view;
    CGRect frame = self.view.bounds;
	frame.origin.x += frame.size.width - kMenuFullWidth;
	frame.size.width = kMenuFullWidth;
    view.frame = frame;
    [self.view insertSubview:view atIndex:0];
    
    frame = rootViewController.view.frame;
    frame.origin.x = -(frame.size.width - kMenuOverlayWidth);
    
    BOOL _enabled = [UIView areAnimationsEnabled];
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    
    rootViewController.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:.3 animations:^{
        rootViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        [click setEnabled:YES];
    }];
    
    if (!animated) {
        [UIView setAnimationsEnabled:_enabled];
    }
}

#pragma mark Setters

- (void)setDelegate:(id<MenuDelegate>)val {
    delegate = val;
    
    _menuFlags.respondsToWillShowViewController = [(id)self.delegate respondsToSelector:@selector(menuController:willShowViewController:)];      
}

- (void)setRightViewController:(UIViewController *)rightController {
    rightViewController = rightController;
    _menuFlags.canShowRight = (rightViewController!=nil);
    [self resetNavButtons];
}

- (void)setLeftViewController:(UIViewController *)leftController {
    leftViewController = leftController;
    _menuFlags.canShowLeft = (leftViewController!=nil);
    [self resetNavButtons];
}

- (void)setRootViewController:(UIViewController *)RootViewController {
    UIViewController *tempRoot = RootViewController;
    rootViewController = RootViewController;
    if (rootViewController) {
        if (tempRoot) {
            [tempRoot.view removeFromSuperview];
            tempRoot = nil;
        }
        UIView *view = rootViewController.view;
        view.frame = self.view.bounds;
        [self.view addSubview:view];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
        pan.delegate = (id<UIGestureRecognizerDelegate>)self;
        [view addGestureRecognizer:pan];
        gesture = pan;
    }else{
        if (tempRoot) {
            [tempRoot.view removeFromSuperview];
            tempRoot = nil;
        }
    }
    [self resetNavButtons];
}

- (void)setRootController:(UIViewController *)controller animated:(BOOL)animated {
    if (!controller) {
        [self setRootViewController:controller];
        return;
    }
    if (_menuFlags.showingLeftView) {
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        // slide out then come back with the new root
        __block MenuViewController *selfRef = self;
        __block UIViewController *rootRef = rootViewController;
        CGRect frame = rootRef.view.frame;
        frame.origin.x = rootRef.view.bounds.size.width;
        
        [UIView animateWithDuration:.1 animations:^{
            
            rootRef.view.frame = frame;
            
        } completion:^(BOOL finished) {
            
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            
            [selfRef setRootViewController:controller];
            rootViewController.view.frame = frame;
            [selfRef showRootController:animated];
            
        }];
    } else {
        // just add the root and move to it if it's not center
        [self setRootViewController:controller];
        [self showRootController:animated];
    }
}

#pragma mark - Root Controller Navigation

/*
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    NSAssert((rootViewController!=nil), @"no root controller set");
    
    UINavigationController *navController = nil;
    
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        
        navController = (UINavigationController*)rootViewController;
        
    } 
    else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UIViewController *topController = [(UITabBarController*)rootViewController selectedViewController];
        if ([topController isKindOfClass:[UINavigationController class]]) {
            navController = (UINavigationController*)topController;
        }
        
    } 
    
    if (navController == nil) {
        
        NSLog(@"root controller is not a navigation controller.");
        return;
    }
    
    
    if (_menuFlags.showingRightView) {
        
        // if we're showing the right it works a bit different, we'll make a screen shot of the menu overlay, then push, and move everything over
        __block CALayer *layer = [CALayer layer];
        CGRect layerFrame = self.view.bounds;
        layer.frame = layerFrame;
        
        UIGraphicsBeginImageContextWithOptions(layerFrame.size, YES, 0);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [self.view.layer renderInContext:ctx];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        layer.contents = (id)image.CGImage;
        
        [self.view.layer addSublayer:layer];
        [navController pushViewController:viewController animated:NO];
        CGRect frame = rootViewController.view.frame;
        frame.origin.x = frame.size.width;
        rootViewController.view.frame = frame;
        frame.origin.x = 0.0f;
        
        CGAffineTransform currentTransform = self.view.transform;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
                
                self.view.transform = CGAffineTransformConcat(currentTransform, CGAffineTransformMakeTranslation(0, -[[UIScreen mainScreen] applicationFrame].size.height));
                
            } else {
                
                self.view.transform = CGAffineTransformConcat(currentTransform, CGAffineTransformMakeTranslation(-[[UIScreen mainScreen] applicationFrame].size.width, 0));
            }
            
            
        } completion:^(BOOL finished) {
            
            [self showRootController:NO];
            self.view.transform = CGAffineTransformConcat(currentTransform, CGAffineTransformMakeTranslation(0.0f, 0.0f));
            [layer removeFromSuperlayer];
            
        }];
        
    } else {
        
        [navController pushViewController:viewController animated:animated];
        
    }
    
}
*/

#pragma mark - Actions 

- (void)showLeft:(id)sender{
    [self showLeftController:YES];
}

- (void)showRight:(id)sender {
    
    [self showRightController:YES];
}

@end
