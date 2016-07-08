//
//  RegistroEmpresa.h
//  Aosmart
//
//  Created by Raúl Gómez on 7/07/16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistroEmpresa : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textDepartamento;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerDepartamento;

@end
