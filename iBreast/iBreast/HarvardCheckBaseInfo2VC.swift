//
//  HarvardCheckBaseInfo2VC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/3.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class HarvardCheckBaseInfo2VC: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableBaseInof2: UITableView!
    let HFCHECK_MENU_SECTION=4
    let harvardBaseInfoCellTag:String="hfcheckBI2TableCell"
    var selfData:NSDictionary?
    let alertPicker:AlertPickerViewController=AlertPickerViewController()
    
    var check_times:[Int]=[Int]()//[1,2,3,4,5,6,7,8,9,10];
    let check_result=[Biopsies.Atypia.NAOrUnknow,Biopsies.Atypia.BenignBreastCondition,Biopsies.Atypia.Hyperplasia_NoAtypia,Biopsies.Atypia.AtypicalHyperplasia,Biopsies.Atypia.LCIS]
    let temp_result=["NA or Unknown","Benign Breast Condition","Hyperplasia NoAtypia","Atypical Hyperplasia","LCIS"]
    var conceive_times:[Int]=[Int]()//=[1,2,3,4,5,6,7,8,9,10]
    var first_haschild_age:[Int]=[Int]()//=[16,17,18,19,20,21,22,23,24,25]
    
    // get a Model object for fill user data  获取一个用于填充用户数据的数据模型对象
  //  var harvardExamModel:HarvardExamModel = HarvardExamModel();
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        alertPicker.delegate=self
        alertPicker.dataSource=self
        alertPicker.mUIViewController=self
        alertPicker.mViewControllerDelegate=self
        
        initHarvardCheckMenuData()
        initSelfData()
        
        tableBaseInof2.dataSource=self
        tableBaseInof2.delegate=self
        
       
       
      
        
        RiskCalcHttp.sharedInstance.wrapPhysicalData(harvardExamModel.physicalDataModel)
    }
    
    func initSelfData(){
    
        selfData=(data!.allValues[HFCHECK_MENU_SECTION] as! NSDictionary)
        //var number:[Int]=[Int]()
        
        // 活检次数赋值
        for i in 1...30 {
            check_times.append(i)
        }
        
        // 怀孕次数
        for i in 1...15 {
            conceive_times.append(i)
        }
        
        // 第一次生孩子的年纪
        for i in 12...55 {
            first_haschild_age.append(i)
        }
    }
//    
//     func scrollViewDidScroll(scrollView: UIScrollView) {
//        
//        var sectionHeaderHeight:Int = 40;
//        
//        if ((scrollView.contentOffset.y <= 40) && (scrollView.contentOffset.y >= 0)){
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        } else if (scrollView.contentOffset.y >= 40) {
//            scrollView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
//        }
//
//    }
//   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        
        println("tableView ---- --  ---click \(indexPath.row)");
        
        var indexId = indexPath.row + (1 * indexPath.section)
        
        if(indexPath.section == 0)
        {
            alertPicker.showPickerInActionSheet(indexPath.row);
        }
        else
        {
            alertPicker.showPickerInActionSheet(indexPath.row+2);
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view:UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 20));
        //view.backgroundColor = UIColor.yellowColor()
        var label:UILabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, 20));
        view.addSubview(label);
        label.textAlignment = NSTextAlignment.Center
        label.text = selfData?.allKeys[section] as! String
        return view;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return (selfData!.allValues[section] as! NSArray).count
        
    }
        func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
//            tableView.headerViewForSection(section)?.textLabel.textAlignment = NSTextAlignment.Center;
           return selfData?.allKeys[section] as! String
        }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 2
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 60
    }
    
   
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        
        let cell=tableView.dequeueReusableCellWithIdentifier(harvardBaseInfoCellTag, forIndexPath: indexPath)
            as? UITableViewCell
        
        
        
        //        var lable=cell!.viewWithTag(TAG_CELL_LABLE) as? UILabel
        //         lable.text=(data!.allValues[indexPath.section] as! NSArray).objectAtIndex(indexPath.row) as! String
        var label=cell?.textLabel?.text=(selfData!.allValues[indexPath.section] as! NSArray).objectAtIndex(indexPath.row) as! String;
        //
        

        if(indexPath.section == 0)
        {
            if (indexPath.row == 0)
            {
                if(harvardExamModel.biopsies.biopsiesNum == nil)
                {
                    harvardExamModel.biopsies.biopsiesNum = check_times[0]
                }
                cell?.detailTextLabel?.text = "\(harvardExamModel.biopsies.biopsiesNum)"
            }
            else if(indexPath.row == 1)
            {
                // change value type
                
                if(harvardExamModel.biopsies.atypia == Biopsies.Atypia.NAOrUnknow)
                {
                    cell?.detailTextLabel?.text = "NA or Unknown";
                }
                else if(harvardExamModel.biopsies.atypia == Biopsies.Atypia.NAOrUnknow){
                    cell?.detailTextLabel?.text = "NA or Unknown"
                }
                else if (harvardExamModel.biopsies.atypia == Biopsies.Atypia.LCIS){
                    cell?.detailTextLabel?.text = "LCIS"
                }
                else if (harvardExamModel.biopsies.atypia == Biopsies.Atypia.BenignBreastCondition){
                    cell?.detailTextLabel?.text = "Benign Breast Condition"
                }
                else if (harvardExamModel.biopsies.atypia == Biopsies.Atypia.Hyperplasia_NoAtypia){
                    cell?.detailTextLabel?.text = "Hyperplasia NoAtypia"
                }
                else if (harvardExamModel.biopsies.atypia == Biopsies.Atypia.AtypicalHyperplasia){
                    cell?.detailTextLabel?.text = "Atypical Hyperplasia"
                }
            }
        }
        else if(indexPath.section == 1)
        {
            if(indexPath.row == 0)
            {
                if(harvardExamModel.childbirthHistory.pregnanciesNum == nil)
                {
                    harvardExamModel.childbirthHistory.pregnanciesNum = conceive_times[0]
                }
                cell?.detailTextLabel?.text = "\(harvardExamModel.childbirthHistory.pregnanciesNum)"
            }
            else if(indexPath.row == 1)
            {
                if(harvardExamModel.childbirthHistory.ageAtFirstLiveBirth == nil)
                {
                    harvardExamModel.childbirthHistory.ageAtFirstLiveBirth = first_haschild_age[0]
                }
                cell?.detailTextLabel?.text = "\(harvardExamModel.childbirthHistory.ageAtFirstLiveBirth)"
            }
        }
        
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

extension HarvardCheckBaseInfo2VC:UIPickerViewDataSource
{
    func numberOfComponentsInPickerView(pickerView:UIPickerView) ->Int
    {
        return 1;
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if(pickerView.tag==0){
            
            return check_times.count
        }
        else if(pickerView.tag == 1){
            
            
            return self.temp_result.count
            
        } else if(pickerView.tag == 2){
            
            
            return self.conceive_times.count
            
        } else if(pickerView.tag==3){
            return self.first_haschild_age.count
        }
        else{
            return 0
        }
        
    }
}

extension HarvardCheckBaseInfo2VC:UIPickerViewDelegate{
    
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if(pickerView.tag == 0){
            
            return "\(check_times[row])"
        }
            
        else if(pickerView.tag == 1){
            return "\(self.temp_result[row] )"
        } else if(pickerView.tag == 2){
            
            
            return "\(self.conceive_times[row])"
            
        }
        else if(pickerView.tag==3){
            return "\(self.first_haschild_age[row])"
        }
        else  {
            
            return "";
            
        }
        
    }
    //
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 0){
            println("you selected the name: \(self.check_times[row])")
            harvardExamModel.biopsies.biopsiesNum = self.conceive_times[row];
        }
            
        else if(pickerView.tag == 1){
            println("you selected the name: \(self.temp_result[row])")
            
            
            
            
            harvardExamModel.biopsies.atypia = self.check_result[row];
            
//            if(harvardExamModel.biopsies.atypia == Biopsies.Atypia.AtypicalHyperplasia)
//            {
//                harvardExamModel.biopsies.atypia ==
//            }
        } else if (pickerView.tag == 2){
            println("you selected the name: \(self.conceive_times[row])")
            harvardExamModel.childbirthHistory.pregnanciesNum = check_times[row];
        }
        else if(pickerView.tag==3){
            println("you selected the name: \(self.first_haschild_age[row])")
            harvardExamModel.childbirthHistory.ageAtFirstLiveBirth = self.first_haschild_age[row];
        }
    }
}

extension HarvardCheckBaseInfo2VC:AlertPickerViewControllerDelegate{
    func didSelect(){
        println("didSelect")
        tableBaseInof2.reloadData();
    }
    func didCancel()
    {
        println("didCancel")
    }
}

