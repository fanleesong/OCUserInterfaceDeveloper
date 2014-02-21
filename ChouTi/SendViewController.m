//
//  SendViewController.m
//  ChouTi
//
//  Created by hh on 13-11-6.
//
//

#import "SendViewController.h"
#import "SendTextViewController.h"
#import "SendPictureViewController.h"

@implementation SendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.jpg"] forBarMetrics:UIBarMetricsDefault];
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bacg.jpg"]];
    self.navigationItem.title = @"发布";
    [self.view setBackgroundColor:bgColor];
}

#pragma mark - buttonMethod

- (IBAction)PictureButton:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"选择类型" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert addButtonWithTitle:@"图库"];
    [alert addButtonWithTitle:@"拍照"];
    [alert show];
    [alert setTag:0];
    [alert autorelease];
}

- (IBAction)TextButton:(id)sender {
    SendTextViewController * text = [[SendTextViewController alloc]initWithNibName:@"SendTextViewController" bundle:nil];
    [self.navigationController pushViewController:text animated:YES];
    [text release];
}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
     if(buttonIndex == 1){
         UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
         imagePickerController.navigationBar.tintColor = [UIColor colorWithRed:72.0/255.0 green:106.0/255.0 blue:154.0/255.0 alpha:1.0];
         imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
         imagePickerController.delegate = self;
         imagePickerController.allowsEditing = NO;
         [self presentModalViewController:imagePickerController animated:YES];
         [imagePickerController release];
    
    }else if(buttonIndex == 2){
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"该设备不支持拍照功能" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            [alert setTag:1];
            [alert release];
        }else{
            UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = NO;
            [self presentModalViewController:imagePickerController animated:YES];
            [imagePickerController release];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    SendPictureViewController * sendPicture =  [[SendPictureViewController alloc]initWithNibName:@"SendPictureViewController" bundle:nil];
    sendPicture.image = image;
    [self.navigationController pushViewController:sendPicture animated:YES];
    [sendPicture release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

@end
