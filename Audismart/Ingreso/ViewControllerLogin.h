//
//  ViewControllerLogin.h
//  Audismart
//
//  Created by Dayana Martinez on 03-02-16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerRegistroUser.h"
#import "JsonParams.h"

@interface ViewControllerLogin : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *emai;


@property (strong, nonatomic) IBOutlet UITextField *contrasena;
@property(strong,nonatomic)ViewControllerRegistroUser *viewControllerRegistroUser;

- (IBAction)ingresar:(id)sender;

@end
