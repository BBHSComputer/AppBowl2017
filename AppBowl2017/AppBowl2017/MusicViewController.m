//
//  MusicViewController.m
//  AppBowl2017
//
//  Created by Ethan Tillison on 26/4/17.
//  Copyright © 2017 Blind Brook Computer Club. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()

@end

@implementation MusicViewController

CGFloat const size = 100;

@synthesize song, score, countdown, scoreLabel;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"C");
	
	[super viewDidAppear:animated];
	
	[self countTo:@3];
	[self performSelector:@selector(countTo:) withObject:@2 afterDelay:1];
	[self performSelector:@selector(countTo:) withObject:@1 afterDelay:2];
	[self performSelector:@selector(startGame) withObject:nil afterDelay:3];
	
	NSLog(@"D");
}

- (void)countTo:(NSNumber *)count {
	[[self countdown] setText:[NSString stringWithFormat:@"%@", count]];
}

- (void)startGame {
	NSLog(@"E");
	
	[[self countdown] setAlpha:0];
	
	NSArray *arr;
	NSString *path;
	switch (song) {
		case 0:
			arr = @[@0, @468, @625, @1250, @1875, @2500, @3750, @4218, @4375, @5000, @5625, @6250, @7500, @7812, @8124, @9062, @9375, @10000, @11250, @11562, @11875, @12500, @13125, @13750, @14375, @15000, @15468, @15625, @16249, @16875, @17500, @18750, @19218, @19375, @20000, @20625, @21250, @22500, @22812, @23125, @24062, @24375, @25000, @26250, @26562, @26875, @27500, @28125, @28750, @29375, @30000, @30468, @30625, @31250, @31875, @32499, @33750, @34062, @34375, @35000, @35625, @36250, @37500, @38125, @39062, @39375, @40000, @41250, @41562, @41875, @42500, @43125, @43750, @45000, @45625, @46250, @46875, @47187, @47500, @48125, @48750, @49375, @50000, @50312, @50625, @50937, @51250, @51875, @53125, @53593, @54062, @55468, @55937, @56406, @56875, @58750, @59218, @59687, @61093, @61562, @62500];
			path = @"starspangledbannermp3";
			break;
		case 1:
			arr = @[@1138, @1897, @2276, @2655, @3035, @3414, @4552, @5691, @6449, @6829, @7208, @7588, @7967, @9864, @10243, @10623, @11002, @11382, @11761, @12140, @12520, @13279, @13658, @14796, @15555, @15934, @16314, @16693, @17073, @17452, @17831, @18211, @18590, @18970, @19349, @20108, @20487, @20867, @21246, @21625, @22764, @23902, @24661, @25040, @25419, @25799, @26178, @27696, @28075, @28455, @29593, @30731, @31110, @31490, @31869, @32249, @32628, @33007, @34146, @35284, @35663, @36043, @36422, @36801, @37181, @37560, @38698];
			path = @"takemeoutmp3";
			break;
		case 2:
			arr = @[@1001, @1252, @1502, @1753, @2003, @2253, @2504, @2754, @3005, @3756, @4006, @4257, @4507, @5259, @5509, @5759, @6010, @6761, @7012, @7262, @7512, @7763, @8013, @8264, @8514, @8765, @9015, @9766, @10017, @10267, @10518, @11269, @11519, @11770, @12020, @13022, @13272, @13523, @13773, @14024, @14274, @14525, @14775, @15025, @15777, @16027, @16278, @16528, @17279, @17530, @17780, @18031, @18782, @19032, @19283, @19533, @19784, @20034, @20285, @20535, @20785, @21036, @21787, @22038, @22288, @22538, @23290, @23540, @23791, @24041, @24792, @25043, @25293, @25544, @26295, @26545, @26796, @27046, @27797, @28048, @28298, @28549, @29300, @29551, @29801, @30051, @30803, @31053, @31804, @32055, @32806, @33057, @33808, @34058, @34309, @34559, @34810, @35060, @35310, @35561, @35811, @36062, @36813, @37063, @37314, @37564, @38316, @38566, @38816, @39067, @39818, @40069, @40319, @40570, @40820, @41070, @41321, @41571, @41822, @42072, @42823, @43074, @43324, @43575, @44326, @44576, @44827, @45077, @45829, @46079, @46329, @46580, @47331, @47582, @47832, @48082, @48834, @49084, @49335, @49585, @50336, @50587, @50837, @51088, @51839, @52089, @52841, @53091, @53842, @54093, @54844, @55095, @55345, @55595, @55846, @56096, @56347, @56597, @56848, @57098, @57849, @58100, @58350, @58601, @59352, @59602, @59853, @60103, @60855, @61105, @61355, @61606, @61856, @62107, @62357, @62608, @62858, @63108, @63860, @64110, @64361, @64611, @65362, @65613, @65863, @66114, @66865, @67115, @67366, @67574, @67616, @68618, @68994, @69119, @69620, @70121, @70496, @70621, @70872, @71122, @71373, @71623, @71874, @72124, @72625, @73042, @73126, @73251, @73376, @73501, @73627, @74628, @74879, @75129, @75880, @76131, @76381, @76632, @77383, @77467, @77508, @77550, @77633, @78009, @78134, @78260, @78385, @78510, @78635, @78760, @78886, @79011, @79136, @79261, @79387, @79512, @79637, @79762, @79887, @80013, @80138, @80263, @80388, @80513, @80639, @80764, @80889, @81014, @81140, @81265, @81390, @81515, @81640, @81766, @81891, @82016, @82141, @82266, @82392, @82517, @82642, @82767, @82893, @83018, @83143, @83268, @83393, @83519, @83644, @83769, @83894, @84020, @84145, @84270, @84395, @84520, @84646, @84771, @84896, @85021, @85146, @85272, @85397, @85522, @85647, @86399, @86649, @86899, @87150, @87901, @88152, @88903, @89153, @89905, @90155, @90406, @90656, @90906, @91157, @91407, @91658, @92409, @92659, @92910, @93160, @93912, @94162, @94412, @94663, @95414, @95665, @95915, @96165, @96416, @96666, @96917, @97167, @97418, @97668, @98419, @98670, @98920, @99171, @99922, @100172, @100423, @100673, @101425, @101675, @101925, @102176, @102927, @103178, @103428, @103678, @104430, @104680, @104931, @105181, @105932, @106183, @106433, @106684, @107435, @107685, @108437, @108687, @109438, @109689, @110440, @110691, @110941, @111191, @111442, @111692, @111943, @112193, @112444, @112694, @113445, @113696, @113946, @114197, @114948, @115198, @115449, @115699, @116450, @116701, @116951, @117202, @117452, @117703, @117953, @118204, @118454, @118704, @119456, @119706, @119957, @120207, @120958, @121209, @121459, @121710, @123212, @124715, @125716, @125967, @126217, @127219, @127720, @129223, @130224, @130475, @130725, @131727, @132228, @132729, @133229, @133730, @135233, @136736, @137737, @137988, @138238, @139240, @139741, @141243, @142245, @142495, @142746, @143748, @144248, @145250, @145751, @147254, @148756, @148923, @149090, @149257, @149424, @149591, @149758, @149925, @150092, @150259, @150426, @150593, @150760, @150927, @151094, @151261, @151428, @151594, @151761, @151928, @152095, @152262, @152429, @152596, @152763, @152930, @153097, @153264, @153431, @153598, @153765, @153932, @154099, @154266, @154433, @154600, @154767, @154934, @155101, @155267, @155434, @155601, @155768, @155935, @156102, @156269, @156520, @156770, @157021, @157271, @157521, @157772, @158523, @158774, @159024, @159274, @160026, @160276, @160527, @160777, @161528, @161779, @162029, @162280, @162530, @162780, @163031, @163281, @163532, @163782, @164533, @164784, @165034, @165285, @166036, @166287, @166537, @166787, @167539, @167789, @168040, @168290, @169041, @169292, @169542, @169793, @170544, @170794, @171045, @171295, @172046, @172297, @172547, @172798, @173549, @173799, @174551, @174801, @175552, @175803, @176554, @176805, @177055, @177306, @177556, @177806, @178057, @178307, @178558, @178808, @179559, @179810, @180060, @180311, @181062, @181312, @181563, @181813, @182565, @182815, @183065, @183316, @183566, @183817, @184067, @184318, @184568, @184818, @185570, @185820, @186071, @186321, @187072, @187323, @187573, @187824];
			path = @"furelisemp3";
			break;
		case 3:
			arr = @[@4500, @5062, @5625, @7125, @7312, @7687, @7875, @8250, @8437, @9000, @9562, @10125, @11625, @11812, @12187, @12375, @12750, @12937, @13500, @14625, @16125, @16312, @16687, @16875, @17437, @18000, @18562, @18937, @19125, @19500, @19687, @20062, @20250, @20625, @20812, @21187, @21375, @21937, @22500, @23062, @23625, @25125, @25312, @25687, @25875, @26250, @26437, @27000, @27562, @28125, @29625, @29812, @30187, @30375, @30750, @30937, @31500, @32625, @34125, @34312, @34687, @34875, @35437, @36000, @36562, @36937, @37125, @37500, @37687, @38062, @38250, @38625, @38812, @39187, @39375, @39937, @40500, @41625];
			path = @"heartandsoulmp3";
			break;
	}
	
	self.numNotes = (int) arr.count;
	
	NSError *error;
	NSString *resPath = [[NSBundle mainBundle] pathForResource:path ofType:@"mp3"];
	NSURL *url = [NSURL fileURLWithPath:resPath];
	NSLog(@"%@", resPath);
	self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	if (error) {
		NSLog(@"Error: %@", error);
	}
	[self.audioPlayer prepareToPlay];
	[self.audioPlayer play];
	
	for (NSNumber *n in arr) {
		[self performSelector:@selector(createNote) withObject:nil afterDelay:[n doubleValue] / 1000];
	}
	[self performSelector:@selector(gameOver) withObject:nil afterDelay:[[arr objectAtIndex:arr.count - 1] doubleValue] / 1000];
	
	NSLog(@"F");
}

- (void)createNote {
	UIView *background = [[UIView alloc] initWithFrame:CGRectMake(arc4random() % ((int) (self.view.frame.size.width - size)), 128 + arc4random() % ((int) (self.view.frame.size.height - size - 128)), size, size)];
	[background.layer setCornerRadius:size / 2];
	[background setBackgroundColor:[UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:1]];
	
	UIButton *note = [UIButton buttonWithType:UIButtonTypeCustom];
	// ♫ BEAMED EIGHTH NOTES Unicode: U+266B, UTF-8: E2 99 AB
	[note setTitle:@"\u266B" forState:UIControlStateNormal];
	[note.titleLabel setFont:[UIFont fontWithName:@"Montserrat" size:36]];
	[note setFrame:CGRectMake(4, 4, size - 8, size - 8)];
	[note.layer setCornerRadius:size / 2 - 4];
	[note setBackgroundColor:[UIColor blueColor]];
	[note setClipsToBounds:YES];
	
	CAShapeLayer *layer = [CAShapeLayer layer];
	UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:note.center radius:size / 2 startAngle:4.7123889804 endAngle:10.9955742876 clockwise:NO];
	[path stroke];
	[layer setPath:[path CGPath]];
	[layer setStrokeColor:[[UIColor redColor] CGColor]];
	[layer setLineWidth:8];
	[layer setFillColor:nil];
	[background.layer addSublayer:layer];
	
	[CATransaction begin];
	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
	[anim setFromValue:@1];
	[anim setToValue:@0];
	[anim setDuration:2];
	[CATransaction setCompletionBlock:^{
		[background setUserInteractionEnabled:NO];
		[note setBackgroundColor:[UIColor redColor]];
		[UIView animateWithDuration:0.25 animations:^{
			[background setAlpha:0];
		} completion:^(BOOL finished) {
			[background removeFromSuperview];
		}];
	}];
	[layer addAnimation:anim forKey:@"strokeStart"];
	[CATransaction commit];
	
	[note addTarget:self action:@selector(notePressed:) forControlEvents:UIControlEventTouchDown];
	
	[background addSubview:note];
	
	[self.view insertSubview:background atIndex:0];
}

- (void)gameOver {
	// [self performSegueWithIdentifier:@"EndMusic" sender:self];
}

- (void)notePressed:(UIButton *)note {
	score++;
	[self.scoreLabel setText:[NSString stringWithFormat:@"Score: %i", score]];
	[note setBackgroundColor:[UIColor greenColor]];
	[note.superview setBackgroundColor:[UIColor lightGrayColor]];
	[note setEnabled:false];
	[UIView animateWithDuration:0.25 animations:^{
		[note.superview setAlpha:0];
	} completion:^(BOOL finished) {
		[note.superview removeFromSuperview];
	}];
	
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([[segue identifier] isEqualToString:@"EndMusic"]) {
		if ([[segue destinationViewController] isKindOfClass:[MusicEndViewController class]]) {
			[(MusicEndViewController *) segue.destinationViewController setScoreString:[NSString stringWithFormat:@"Notes Hit: %i/%i", self.score, self.numNotes]];
		}
	}
}

@end
