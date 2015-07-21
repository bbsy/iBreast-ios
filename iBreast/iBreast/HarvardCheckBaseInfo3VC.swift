//
//  HarvardCheckBaseInfo3VC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/3.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class HarvardCheckBaseInfo3VC: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableBaseInfo3: UITableView!
    
    let HFCHECK_MENU_SECTION=0
    let harvardBaseInfoCellTag:String="hfcheckBI3TableCell"
    var selfData:NSDictionary?
    
    var menarche_days=[12,13,14,15,16,17,18,19,20,21,22,23,24,25];
    let menopause_info=[MenopauseStatus.Peri,MenopauseStatus.Post,MenopauseStatus.Pre,MenopauseStatus.Unknown]
    let ovary_isremove=[YesNoUnknown.No,YesNoUnknown.Yes,YesNoUnknown.Unknown]
    let ovary_remove_age=[14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
    let descent=[CommonAnswer.Yes,CommonAnswer.No,CommonAnswer.NotSure,CommonAnswer.PreferNotToAnswer]
//    let family_bg = ["混血家族","正常家族","病史家族"];
    let family_bg=[Ethnicity.RacialBackground.AfricanAmericanOrBlack,Ethnicity.RacialBackground.American_Indian_Aleutian_Eskimo,Ethnicity.RacialBackground.AsionOrPacificIslander,Ethnicity.RacialBackground.Caribbean_WestIndian,Ethnicity.RacialBackground.CaucasianOrWhite,Ethnicity.RacialBackground.Other]
    let alertPicker:AlertPickerViewController=AlertPickerViewController()
    
    // get a Model object for fill user data  获取一个用于填充用户数据的数据模型对象
    var harvardExamModel:HarvardExamModel = HarvardExamModel();
    
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
        
        tableBaseInfo3.dataSource=self
        tableBaseInfo3.delegate=self
    }
    
    func initSelfData(){
        
        selfData=(data!.allValues[HFCHECK_MENU_SECTION] as! NSDictionary)
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        
        println("tableView ---- --  ---click \(indexPath.row)");
        
        var indexId = indexPath.row + (1 * indexPath.section)
        
        if(indexPath.section == 0)
        {
            alertPicker.showPickerInActionSheet(indexPath.row);
        }
        else
        {
            alertPicker.showPickerInActionSheet(indexPath.row+4);
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return (selfData!.allValues[section] as! NSArray).count
        
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        
        return selfData?.allKeys[section] as! String
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 2
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        
        let cell=tableView.dequeueReusableCellWithIdentifier(harvardBaseInfoCellTag, forIndexPath: indexPath)
            as? UITableViewCell
        
        
        
        //        var lable=cell!.viewWithTag(TAG_CELL_LABLE) as? UILabel
        //         lable.text=(data!.allValues[indexPath.section] as! NSArray).objectAtIndex(indexPath.row) as! String
        var label=cell?.textLabel?.text=(selfData!.allValues[indexPath.section] as! NSArray).objectAtIndex(indexPath.row) as! String;
        //
        
        
        
        cell?.detailTextLabel?.text=String(indexPath.row)
        
        return cell!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HarvardCheckBaseInfo3VC:UIPickerViewDataSource
{
    func numberOfComponentsInPickerView(pickerView:UIPickerView) ->Int
    {
        return 1;
    }

    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if(pickerView.tag==0){
            
            return menarche_days.count
        }
        else if(pickerView.tag == 1){
            
            
            return self.menopause_info.count
            
        } else if(pickerView.tag == 2){
            
            
            return self.ovary_isremove.count
            
        } else if(pickerView.tag==3)
        {
            return self.ovary_remove_age.count
        }
        else if(pickerView.tag==4)
        {
            return self.descent.count
        }
        else if(pickerView.tag==5)
        {
            return self.family_bg.count
        }
            
        else{
            return 0
        }
        
    }
}

extension HarvardCheckBaseInfo3VC:UIPickerViewDelegate{
    

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if(pickerView.tag == 0){
            
            return "\(menarche_days[row])"
        }
            
        else if(pickerView.tag == 1){
            return "\(self.menopause_info[row] )"
        } else if(pickerView.tag == 2){
            
            
            return "\(self.ovary_isremove[row])"
            
        }
        else if(pickerView.tag==3){
            return "\(self.ovary_remove_age[row])"
        }
        else if(pickerView.tag==4){
            return "\(self.descent[row])"
        }
        else if(pickerView.tag==5){
            return "\(self.family_bg[row])"
        }
        else  {
            
            return "";
            
        }
        
    }
    //
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if(pickerView.tag == 0){
                println("you selected the name: \(self.menarche_days[row])")
                harvardExamModel.menstrualHistory.firstPeriodAga = self.menarche_days[row];
            }

            else if(pickerView.tag == 1){
                println("you selected the name: \(self.menopause_info[row])")
                harvardExamModel.menstrualHistory.menopauseStatus = self.menopause_info[row];
            } else if (pickerView.tag == 2){
                    println("you selected the name: \(self.ovary_isremove[row])")
                harvardExamModel.menstrualHistory.isBothovariesRemoved = self.ovary_isremove[row];
            }
            else if(pickerView.tag==3){
                println("you selected the name: \(self.ovary_remove_age[row])")
                harvardExamModel.menstrualHistory.ovaryRemovalAge = self.ovary_remove_age[row];
            }
            else if(pickerView.tag == 4)
            {
                harvardExamModel.ethnicity.isGrandparentsOfJewishDescent = self.descent[row]
            }
            else if(pickerView.tag == 5)
            {
                harvardExamModel.ethnicity.racialBackground = self.family_bg[row]
            }
    }
}

extension HarvardCheckBaseInfo3VC:AlertPickerViewControllerDelegate{
    func didSelect(){
        println("didSelect")
    }
    func didCancel()
    {
        println("didCancel")
    }
}