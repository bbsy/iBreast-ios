//
//  HarhardCheckBaseInfo1.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/3.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

var data:NSDictionary?

func initHarvardCheckMenuData(){
    
    if data==nil
    {
        var pathStr = NSBundle.mainBundle().pathForResource("harvardMenuList", ofType:"plist")
        if let newPathStr = pathStr //pathStr可能为nil
        {
            data = NSDictionary(contentsOfFile: newPathStr);
            
        }
    }

}
class SectionAndRow{
    var section:Int = -1
    var row:Int = -1
}

//var harvardExamModel:HarvardExamModel = HarvardExamModel();


class HarvardCheckBaseInfo1: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableMenu: UITableView!
    let harvardBaseInfoCellTag:String="hfcheckBI1TableCell"
    
    var age:[Int]=[Int]()//=[18,19,20,21,22,23,24];
    
    //:[Int]=[Int]()
    let weight = [20,25,30,35,40,45,50,55,60,65,70,80,90,100,110,120,130,140,150]
    let gender = ["男","女"]
    let height = [100,110,120,130,140,150,160,170,180,190,200];
    
    var indexOfAllRows:Int=0
    
    let HFCHECK_MENU_SECTION=3
    
    let alertPicker:AlertPickerViewController=AlertPickerViewController()
    
    // get a Model object for fill user data  获取一个用于填充用户数据的数据模型对象
    //var harvardExamModel:HarvardExamModel = HarvardExamModel();
 
    
    required init(coder aDecoder: NSCoder) {
        
       
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        alertPicker.delegate=self
        alertPicker.dataSource=self
        alertPicker.mUIViewController=self
        alertPicker.mViewControllerDelegate=self
        
        tableMenu.dataSource=self
        tableMenu.delegate=self
        
        initHarvardCheckMenuData()
        initData()
        

        RiskCalcHttp.sharedInstance.wrapFamilyInfo(mHarvardCheckModel)
       }
    
    func initData(){
        
////        var index:Int = 0;
//        for var num:Int=18; num<99;++num{
////          age[index]
////            index ++；
//            
//        }
        // 年纪
        for i in 10...105 {
            age.append(i)
        }
//        // 体重
//        for i in 1...30 {
//            age.append(10+i*5)
//            println("  age=\(age[i])  i=\(i)");
//        }
//        // 身高  100 - 200
//        for i in 1...20 {
//            age.append(100+i+5)
//        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        
    
        
        indexOfAllRows=indexPath.row
        
        alertPicker.showPickerInActionSheet(indexOfAllRows)
        
        println("section:\(indexPath.section)>>>row:\(indexPath.row)")
    }
    
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return (data!.allValues[HFCHECK_MENU_SECTION] as! NSArray).count
        
    }
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
//        
//        
//       return data?.allKeys[HFCHECK_MENU_SECTION] as! String
//    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    
    var selectIndex:Int = 0;
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        
        let cell=tableView.dequeueReusableCellWithIdentifier(harvardBaseInfoCellTag, forIndexPath: indexPath)
                   as? UITableViewCell
        
        
        
        //        var lable=cell!.viewWithTag(TAG_CELL_LABLE) as? UILabel
        //         lable.text=(data!.allValues[indexPath.section] as! NSArray).objectAtIndex(indexPath.row) as! String
        var label=cell?.textLabel?.text=(data!.allValues[HFCHECK_MENU_SECTION] as! NSArray).objectAtIndex(indexPath.row) as! String;
        //
        
        //这行是性别
        if(indexPath.row==0){
            
            
            var gender = "男"
            
            if let gen = harvardExamModel.physicalDataModel.gender
            {
                if gen == 2 {
                    gender = "女"
                }
                else {
                    gender = "男"
                }
            }
           cell?.detailTextLabel?.text = "\( gender)"
        }//年龄
        else  if(indexPath.row==1){
            if(harvardExamModel.physicalDataModel.age == nil )
            {
                harvardExamModel.physicalDataModel.age = age[0];
            }
            cell?.detailTextLabel?.text = "\( harvardExamModel.physicalDataModel.age)"
        }//体重
        else  if(indexPath.row==2){
            if(harvardExamModel.physicalDataModel.weight == nil)
            {
                harvardExamModel.physicalDataModel.weight = weight[0];
            }
             cell?.detailTextLabel?.text = "\( harvardExamModel.physicalDataModel.weight) kg"
        }//身高
        else  if(indexPath.row==3){
            if(harvardExamModel.physicalDataModel.height == nil)
            {
                harvardExamModel.physicalDataModel.height = height[0];
            }
             cell?.detailTextLabel?.text = "\( harvardExamModel.physicalDataModel.height) cm"
        }

        
 //       cell?.detailTextLabel?.text =  String(indexPath.row)
        
//        if(indexPath.row == 0)
//        {
//            cell?.detailTextLabel?.text =  gender[selectIndex]; //String(indexPath.row)
//        }
//        else if(indexPath.row == 1)
//        {
//            cell?.detailTextLabel?.text = self.age[selectIndex];
//        }
        
        return cell!
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HarvardCheckBaseInfo1:UIPickerViewDataSource{
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if(pickerView.tag==0){
            
            return gender.count
        }
        else if(pickerView.tag == 1){
            
            
            return self.age.count
            
        } else if(pickerView.tag == 2){
            
            
            return self.weight.count
            
        } else if(pickerView.tag==3){
            return self.height.count
        }
        else{
             return 0
        }
        
    }
    
}


extension HarvardCheckBaseInfo1:UIPickerViewDelegate{
    
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if(pickerView.tag == 0){
            
            return gender[row]
        }
        
       else if(pickerView.tag == 1){
            return "\(self.age[row] )"
        } else if(pickerView.tag == 2){
            
            
            return "\(self.weight[row < self.weight.count ? row:(row-1)])kg"
            
        }
        else if(pickerView.tag==3){
            return "\(self.height[row < self.height.count ? row:(row-1)])cm"
        }
        else  {
            
            return "";
            
        }
        
    }
    //
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 0){
         println("you selected the name: \(self.gender[row])")
            harvardExamModel.physicalDataModel.gender = (row+1);
//            tableMenu.reloadRowsAtIndexPaths(<#indexPaths: [AnyObject]#>, withRowAnimation: <#UITableViewRowAnimation#>)
        }
        
        else if(pickerView.tag == 1){
            println("you selected the name: \(self.age[row])")
            harvardExamModel.physicalDataModel.age = self.age[row];
        } else if (pickerView.tag == 2){
            println("you selected the name: \(self.weight[row])")
            harvardExamModel.physicalDataModel.weight = self.weight[row];
        }
        else if(pickerView.tag==3){
             println("you selected the name: \(self.height[row])")
            harvardExamModel.physicalDataModel.height = self.height[row];
        }
        
    }
}

extension HarvardCheckBaseInfo1:AlertPickerViewControllerDelegate{
    func didSelect(){
        
        
        tableMenu.reloadData()

        println("didSelect")
        
    }
    func didCancel()
    {
        println("didCancel")
    }
}

