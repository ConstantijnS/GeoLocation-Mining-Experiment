//
//  MainViewController.m
//  Experiment1
//
//  Created by Constantijn Smit on 16-12-13.
//  Copyright (c) 2013 Constantijn Smit. All rights reserved.
//

#import "MainViewController.h"
#import "Hub.h"
#import "Distributor.h"

@interface MainViewController () {
  UIButton *GPSButton;
  
  UILabel *labelN;
  UILabel *labelE;
  UILabel *labelS;
  UILabel *labelW;
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.title = @"Main";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
  
  // GPSButton is a toggle button. Use the selected state of a UIButton to toggle.
  // UIButton is added as a custom view to the UIBarButtonItem.
  GPSButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
  [GPSButton setImage:[UIImage imageNamed:@"GPSIcon.png"] forState:UIControlStateNormal];
  [GPSButton setImage:[UIImage imageNamed:@"GPSIconSelected.png"] forState:UIControlStateSelected];
  [GPSButton addTarget:self action:@selector(toggleGPSLocation:) forControlEvents:UIControlEventTouchUpInside];
  GPSButton.enabled = YES;
  
  UIBarButtonItem *GPSButtonView = [[UIBarButtonItem alloc] initWithCustomView:GPSButton];
  
  self.navigationItem.leftBarButtonItem = GPSButtonView;
  
  // The hub object is the only object the MainViewController communicates with to access model-objects like locationManager and Distributor.
  if (_hub == nil) {
    _hub = [[Hub alloc] init];
  }
  
  // MainViewController is delegate of Hub. It can receive messages from Hub.
  _hub.delegate = self;
  
  // display gamepointN, E, S, W.
  labelN = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, 300, 50)];
  NSString *stringGamepointN = [NSString stringWithFormat:@"%@", _hub.distributor.gamepointN];
  labelN.text = stringGamepointN;
  [self.view addSubview:labelN];
  
  labelE = [[UILabel alloc] initWithFrame:CGRectMake(250, 200, 300, 50)];
  NSString *stringGamepointE = [NSString stringWithFormat:@"%@", _hub.distributor.gamepointE];
  labelE.text = stringGamepointE;
  [self.view addSubview:labelE];
  
  labelS = [[UILabel alloc] initWithFrame:CGRectMake(150, 300, 300, 50)];
  NSString *stringGamepointS = [NSString stringWithFormat:@"%@", _hub.distributor.gamepointS];
  labelS.text = stringGamepointS;
  [self.view addSubview:labelS];
  
  labelW = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 50)];
  NSString *stringGamepointW = [NSString stringWithFormat:@"%@", _hub.distributor.gamepointW];
  labelW.text = stringGamepointW;
  [self.view addSubview:labelW];
  
  //**TEST**
  // add consume button
  UIButton* consume = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [consume setTitle:@"Consume" forState:UIControlStateNormal];
  consume.frame = CGRectMake(150, 350, 100, 50);
  [consume addTarget:self action:@selector(consume) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:consume];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toggleGPSLocation:(id)sender {
  
  // If checked, uncheck and vice versa
  [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
  
  if ([(UIButton *)sender isSelected])
  {
    // Start updating location
    [_hub.locationManager startStandardUpdates];
    
  } else
  {
    // Stop updating location.
    [_hub.locationManager stopStandardUpdates];
  }
}

-(void) consume {
  [_hub nextTurn];
}

#pragma mark Delegate methods

-(void) didStopUpdating {
  [GPSButton setSelected:NO];
}

-(void) didUpdateGamepoints {
  labelN.text = [NSString stringWithFormat:@"%@", _hub.distributor.gamepointN];
  labelE.text = [NSString stringWithFormat:@"%@", _hub.distributor.gamepointE];
  labelS.text = [NSString stringWithFormat:@"%@", _hub.distributor.gamepointS];
  labelW.text = [NSString stringWithFormat:@"%@", _hub.distributor.gamepointW];
}


@end
