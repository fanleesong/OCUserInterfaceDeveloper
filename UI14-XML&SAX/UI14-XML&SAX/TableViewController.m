//
//  TableViewController.m
//  UI14-XML&SAX
//
//  Created by 范林松 on 14-3-3.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "TableViewController.h"
#import "Students.h"

@interface TableViewController ()
{

    NSString *_startElement;
    
}


@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark-实现方法-
-(NSData *)loadFile{
    
    //获取指定文件路径文件
       NSString *xmlPath = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"student" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",xmlPath);
    //转换为NSData
    NSData *stuData = [xmlPath dataUsingEncoding:NSUTF8StringEncoding];
    
    return stuData;
}


#pragma mark--xmlParser Delegate--
//开始解析
-(void)parserDidStartDocument:(NSXMLParser *)parser{

    NSLog(@"%s",__FUNCTION__);
    self.stuArray = [NSMutableArray array];
    

}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"elementName=%@",elementName);
    
    if ([elementName isEqualToString:@"student"]) {
        
        Students *xmlStu = [[Students alloc] init];
        [self.stuArray addObject:xmlStu];
        [xmlStu release],xmlStu = nil;
        
    }
    _startElement = elementName;
    
    
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"string=%@",string);
//    if (![string isEqualToString:@"\n"]) {
    
        Students *findStu = [self.stuArray lastObject];
        if ([_startElement isEqualToString:@"telephondeNumber"]) {
            findStu.telephoneNumber = string;
        }
        else if ([_startElement isEqualToString:@"name"]) {
            findStu.name = string;
        }
        else if ([_startElement isEqualToString:@"gender"]) {
            findStu.gender = string;
        }
        
//    }
    
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    NSLog(@"%s",__FUNCTION__);
//    NSLog(@"elementName=%@",[self.stuArray]);
    _startElement = nil;
}


//接收解析
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"-------%@",[[self.stuArray lastObject] name]);
    [self.tableView reloadData];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    //实例化xmlParser对象，并通过其初始化方法得到要解析的数据文件并完成解析
//    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:[self loadFile]];
//    //接收xmlParser协议
//    xmlParser.delegate = self;
//    /*-----------------------------------------------*/
//    xmlParser.shouldProcessNamespaces = NO;//是否处理命名空间
//    xmlParser.shouldReportNamespacePrefixes = NO;//是否通知命名空间前缀
//    xmlParser.shouldResolveExternalEntities = NO;//是否处理外部标签实体
//    //开始解析
//    [xmlParser parse];
//    /*-----------------------------------------------*/

    
    
    
    /*-----------------使用JSON解析------------------*/
    //1.获取JSON文件
    NSString *jsonString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"students" ofType:@"json"]encoding:NSUTF8StringEncoding error:nil];
    //2.实例化JSON解析器
    NSDictionary *jsonSerial = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *value = [jsonSerial objectForKey:@"students"];
    self.stuArray = [NSMutableArray array];
    for (int i=0; i<value.count; i++) {
        NSDictionary *dic = [value objectAtIndex:i];
        Students *stus = [[Students alloc] init];
        stus.name = [dic objectForKey:@"name"];
        stus.telephoneNumber = [dic objectForKey:@"telephoneNumber"];
        stus.gender = [dic objectForKey:@"gender"];
        [self.stuArray addObject:stus];
        [stus release],stus = nil;
    }
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"%d",self.stuArray.count);
    return self.stuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Students *stu = [self.stuArray objectAtIndex:indexPath.row];
    NSLog(@"%@",stu);
    cell.textLabel.text = stu.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",stu.gender,stu.telephoneNumber];
//    [stu release],stu = nil;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
-(void)dealloc{

    [_stuArray release];
    [super dealloc];

}

@end
