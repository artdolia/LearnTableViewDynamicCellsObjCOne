//
//  ViewController.m
//  L30_dynamic_cells
//
//  Created by Artsiom Dolia on 1/2/15.
//  Copyright (c) 2015 Artsiom Dolia. All rights reserved.
//

#import "ViewController.h"
#import "RandomColor.h"
#import "Student.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray * colors;
@property (strong, nonatomic) NSMutableArray *students;

@property (strong, nonatomic) NSMutableArray *studentsGroupA;
@property (strong, nonatomic) NSMutableArray *studentsGroupB;
@property (strong, nonatomic) NSMutableArray *studentsGroupC;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(40, 0, 0, 0);
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
    
    
    //************* level Student **********************
    //create RandomColor objects, create table showing the title in color from RandomColor obj.
    
    //create 10 objects of randomColor
    
    self.colors = [NSMutableArray array];
    
    for(int i = 0; i<10; i++){
        
        RandomColor *color = [[RandomColor alloc]init];
        color.colorName = [NSString stringWithFormat:@"Color-%d", i];
        [self.colors addObject:color];
    }
    
    
    /************* level Master **********************
    //create Students and table showing student's name and average grade,
    //differentiate title's font color depending on avearage grade, sort by name.
    
    //create 20 random students
    self.students = [NSArray array];
    
    NSMutableArray *students = [NSMutableArray array];
    
    for (int i = 0; i<20; i++) {
        Student *student = [[Student alloc] init];
        [students addObject:student];
    }
    
    self.students = [students sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        Student *studOne = obj1;
        Student *studTwo = obj2;
     
        return [(NSString *)studOne.studentName compare:(NSString *)studTwo.studentName options:NSNumericSearch];

    }];
    */
    
    //************* level Superman **********************
    //similar to Master, also differentiate students in groups by average grade,
    //sort students in groups.
    //Add group for RandomColor from Student, use two identifiers to
    //create cells of two types.
    

    //create 20 random students and sorted them in three groups
    
    self.studentsGroupA = [NSMutableArray array];
    self.studentsGroupB = [NSMutableArray array];
    self.studentsGroupC = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        Student *student = [[Student alloc] init];
        
        if (student.averageGrade < 3.f) {
            [self.studentsGroupC addObject:student];
        }else if (student.averageGrade >= 3.f && student.averageGrade < 3.5f) {
            [self.studentsGroupB addObject:student];
        }else{
            [self.studentsGroupA addObject:student];
        }
    }
    
    self.students = [NSMutableArray arrayWithObjects:self.studentsGroupA, self.studentsGroupB, self.studentsGroupC, self.colors, nil];
    
    for (int j = 0; j < self.students.count-1; j++) {
        
        NSArray *tmpStudents = [NSArray array];
        
        if ([[self.students objectAtIndex:j] count] > 1) {
            tmpStudents = [[self.students objectAtIndex:j] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            Student *studOne = obj1;
            Student *studTwo = obj2;
            return [(NSString *)studOne.studentName compare:(NSString *)studTwo.studentName options:NSNumericSearch];
            }];
        }
        
        [self.students replaceObjectAtIndex:j withObject:tmpStudents];
    }
    
    NSLog(@"%@",self.students);
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //NSLog(@"Groups: %lu", (unsigned long)self.students.count);
    return self.students.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //return self.colors.count;
    //NSLog(@"Group: %lu, students:%lu", (unsigned long)self.students.count, [[self.students objectAtIndex:section] count]);
    
    return [[self.students objectAtIndex:section] count];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
     */
    
    
    /************* level Student **********************
     
    RandomColor *color = [self.colors objectAtIndex:indexPath.row];
    UIColor *randomColor = color.color;
    CGFloat red, green, blue, alpha = [randomColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - R:%.2f: G:%.2f: B:%.2f", color.colorName, red, green, blue];
    
    //cell.textLabel.textColor = randomColor;
    cell.backgroundColor = randomColor;
     */
    
    
    
    /************* level Master **********************
    
    Student *student = [self.students objectAtIndex:indexPath.row];
    
    cell.textLabel.text = student.studentName;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", student.averageGrade];
    
    cell.textLabel.textColor = student.averageGrade > 3.5f ? [UIColor blackColor] : [UIColor redColor];
     
    */
    
    
    //************* level Superman **********************
    
    id obj =[[self.students objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSLog(@"%@", obj);
    
    static NSString *identifierStudent = @"identifierStudent";
    static NSString *denttifierColor = @"denttifierColor";
    
    
    UITableViewCell *cell = ([obj isKindOfClass:[Student class]])? [tableView dequeueReusableCellWithIdentifier:identifierStudent] :
    [tableView dequeueReusableCellWithIdentifier:denttifierColor];
    
    if([obj isKindOfClass:[Student class]]){
        
        if(!cell){
        
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifierStudent];
        }
        
        Student *student = obj;
        cell.textLabel.text = student.studentName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", student.averageGrade];
        cell.textLabel.textColor = student.averageGrade > 3.5f ? [UIColor blackColor] : [UIColor redColor];
    
    }else {
        
        if(!cell){
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:denttifierColor];
        }
        
        RandomColor *color = obj;
        CGFloat red, green, blue, alpha = [color.color getRed:&red green:&green blue:&blue alpha:&alpha];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - R:%.2f: G:%.2f: B:%.2f", color.colorName, red, green, blue];
        cell.textLabel.textColor = color.color;
    }
    
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [self getSectionHeaderTitle:section];
    
}


#pragma mark - Private methods

-(NSString *) getSectionHeaderTitle:(NSInteger) section{
    
    return section == 0 ? @"Group A" :
            (section == 1 ? @"Group B" :
             (section ==2 ? @"Group C" : @"Color Group"));
}

/*
-(UIColor *) getRandomRGBColor{
    
    CGFloat redComponent = (float)(arc4random()%256) / 255;
    CGFloat blueComponent = (float)(arc4random()%256) / 255;
    CGFloat greenComponent = (float)(arc4random()%256) / 255;
    
    return [UIColor colorWithRed:redComponent green:greenComponent blue:blueComponent alpha:1.f];
}
*/


@end
