//
//  QCRegistViewController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCRegistViewController.h"
#import <SMS_SDK/SMSSDK.h>


@interface QCRegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *number;

@end

@implementation QCRegistViewController

- (IBAction)getSmsCode:(UIButton *)sender {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.textField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (error) {
            NSLog(@"error %@",error);
        }else{
            NSLog(@"验证码发送成功");
        }
    }];
}

- (IBAction)regist:(UIButton *)sender {
    [SMSSDK commitVerificationCode:self.number.text phoneNumber:self.textField.text zone:@"86" result:^(NSError *error) {
        
        if (error) {
            UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"真遗憾！" message:@"您的验证码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert1 setAlertViewStyle:UIAlertViewStyleDefault];
            [alert1 show];
            
        }else{
            UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"恭喜你！" message:@"注册成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert2 setAlertViewStyle:UIAlertViewStyleDefault];
            [alert2 show];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
