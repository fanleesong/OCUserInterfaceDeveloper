//
//  SendTextViewController.m
//  ChouTi
//
//  Created by hh on 13-11-6.
//
//

#import "SendTextViewController.h"

@implementation SendTextViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.jpg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    TextcountLabael.text = @"150";
    manager = [HTTPMessageManager getInstance];
}

- (void)viewDidUnload {
    [TextView release];
    TextView = nil;
    [TextcountLabael release];
    TextcountLabael = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    [TextView release];
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

- (IBAction)keyboardButton:(id)sender {
    [TextView resignFirstResponder];
}

- (IBAction)sendButton:(id)sender {
    [manager postTextMessage:TextView.text];
}

- (IBAction)selectButton:(id)sender {
    
}
@end
