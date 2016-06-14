//
//  RecuperarViewController.h
//  Audismart
//
//  Created by Dayana Martinez on 30-01-16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonParams.h"

@interface RecuperarViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *textFieldEmail;
    
}
@property (strong, nonatomic) JsonParams* jsonParams;
@property (strong, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (strong, nonatomic) IBOutlet UIButton *buttonEnviarContrasena;
@end

