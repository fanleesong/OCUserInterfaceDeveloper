//
//  SendPictureViewController.m
//  ChouTi
//
//  Created by hh on 13-11-5.
//
//

#import "SendPictureViewController.h"

@implementation SendPictureViewController
@synthesize imageView,image;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.jpg"] forBarMetrics:UIBarMetricsDefault];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    imageView.image = image;
    TextcountLabael.text = @"150";
    manager = [HTTPMessageManager getInstance];
}

- (void)viewDidUnload {
    [TextView release];
    TextView = nil;
    [imageView release];
    imageView = nil;
    [TextcountLabael release];
    TextcountLabael = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    [TextView release];
    [imageView release];
    [TextcountLabael release];
    [super dealloc];
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString  * TextContent = textView.text;
    int   existTextNum = [TextContent length];
    remainTextNum = 150-existTextNum;
    TextcountLabael.text = [NSString stringWithFormat:@"%d",remainTextNum];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (range.location > 149) {
        return NO;
    }
    else{
        return YES;
    }
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)sendButton:(id)sender {
    NSData *data = UIImageJPEGRepresentation(imageView.image, 1);
    [manager postPicMessage:data andText:TextView.text];
}

- (IBAction)selectButton:(id)sender {
   
}

@end
