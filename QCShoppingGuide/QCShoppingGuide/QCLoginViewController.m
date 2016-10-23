//
//  QCLoginViewController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCLoginViewController.h"
#import "QCNetworkTool.h"
#import "QCRegistViewController.h"

@interface QCLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation QCLoginViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.phoneNum becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNav];
}

-(void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(regist:)];
    
    self.phoneNum.delegate = self;
    self.pwdTF.delegate = self;
}

-(void)cancel:(UIBarButtonItem *)item{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)regist:(UIBarButtonItem *)item{
    QCRegistViewController *registVc = [[QCRegistViewController alloc]init];
    [self.navigationController pushViewController:registVc animated:YES];
}


- (IBAction)loginIn:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.phoneNum.text;
    params[@"password"] = self.pwdTF.text;
    
    [[QCNetworkTool sharedNetworkTool]loadDataInfoPost:@"http://api.dantangapp.com/v1/account/signin" parameters:params success:^(id responseObject) {
        NSString *status = responseObject[@"message"];
        if ([status isEqualToString:@"OK"]) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            QCUser *user = [QCUser mj_objectWithKeyValues:responseObject[@"data"]];
            
            if (weakSelf.block) {
                weakSelf.block(user);
            }
            //退出登录界面
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
    }];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    self.loginBtn.enabled = (self.phoneNum.text.length>0 && self.pwdTF.text.length > 0)? YES:NO;
    return YES;
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
