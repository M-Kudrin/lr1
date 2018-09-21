//
//  SendFeedbackViewController.m
//  GitHubTrending
//
//  Created by Developer on 18/09/2018.
//  Copyright © 2018 Developer. All rights reserved.
//

#import "SendFeedbackViewController.h"
#import <MessageUI/MessageUI.h>

@interface SendFeedbackViewController () <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *messageBodyTextView;

@end

@implementation SendFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)sendAction:(id)sender {
    [self sendEmail];
}

- (void)sendEmail {
    NSString *emailTitle = @"GitHub Trending Feedback";
    NSString *messageBody = self.messageBodyTextView.text;
    NSArray *toRecipents = [NSArray arrayWithObject:@"sergey.u.petrushin@gmail.com"];
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    [self presentViewController:mc animated:YES completion:nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
