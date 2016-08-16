//
//  RegistroEmpresa.h
//  Aosmart
//
//  Created by Raúl Gómez on 7/07/16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistroEmpresa : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, retain) NSMutableArray *autocompleteUrls;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

#pragma mark Datos del Registro
@property (strong, nonatomic) IBOutlet UITextField *tfNombreEmpresa;
@property (strong, nonatomic) IBOutlet UITextField *tfDepartamento;
@property (strong, nonatomic) IBOutlet UITextField *tfCiudad;
@property (strong, nonatomic) IBOutlet UITextField *tfTipodocumento;
@property (strong, nonatomic) IBOutlet UITextField *tfNumeroDocumento;
@property (strong, nonatomic) IBOutlet UITextField *tfFechaRegistroMercantil;
@property (strong, nonatomic) IBOutlet UITextField *tfIngresos;
@property (strong, nonatomic) IBOutlet UITextField *tfPeriodicidad;
@property (strong, nonatomic) IBOutlet UITextField *tfRegimen;
@property (strong, nonatomic) IBOutlet UISwitch *switchImpuesto;
@property (strong, nonatomic) IBOutlet UISwitch *switchContribuyente;


@property (strong, nonatomic) IBOutlet UIButton *btFinalizarREgistro;

#pragma mark Tablas
@property (nonatomic, retain) UITableView *autocompleteDocumentosTableView;
@property (nonatomic, retain) UITableView *autocompletePeriodicidadTableView;
@property (nonatomic, retain) UITableView *autocompleteCategoriaTableView;

@end
