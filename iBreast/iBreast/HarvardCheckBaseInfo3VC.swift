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
    let menopause_info_temp=["Peri","Post","Pre","Unknown"]
    let ovary_isremove=[YesNoUnknown.No,YesNoUnknown.Yes,YesNoUnknown.Unknown]
    let ovary_isremove_temp=["No","Yes","Unknown"]
    let ovary_remove_age=[14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
    let descent=[CommonAnswer.Yes,CommonAnswer.No,CommonAnswer.NotSure,CommonAnswer.PreferNotToAnswer]
    let descent_temp=["Yes","No","Not Sure","Prefer Not To Answer"]
//    let family_bg = ["混血家族","正常家族","病史家族"];
    let family_bg=[Ethnicity.RacialBackground.AfricanAmericanOrBlack,Ethnicity.RacialBackground.American_Indian_Aleutian_Eskimo,Ethnicity.RacialBackground.AsionOrPacificIslander,Ethnicity.RacialBackground.Caribbean_WestIndian,Ethnicity.RacialBackground.CaucasianOrWhite,Ethnicity.RacialBackground.Other]
        let family_bg_temp=["African American Or Black","American Indian Aleutian Eskimo","Asion Or Pacific Islander","Caribbean WestIndian","Caucasian Or White","Other"]
    let alertPicker:AlertPickerViewController=AlertPickerViewController()
    
    // get a Model object for fill user data  获取一个用于填充用户数据的数据模型对象
    //var harvardExamModel:HarvardExamModel = HarvardExamModel();
    
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
        
        RiskCalcHttp.sharedInstance.wrapBiopsies(harvardExamModel.biopsies)
        RiskCalcHttp.sharedInstance.wrapChildbirthHistory(harvardExamModel.childbirthHistory)
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
    
    // 设置自定义的Section View视图，并在此添加自己的label，并设置居中
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view:UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 20));
        //view.backgroundColor = UIColor.brownColor()//.yellowColor()
        var label:UILabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, 20));
        view.addSubview(label);
        label.textAlignment = NSTextAlignment.Center
        label.text = selfData?.allKeys[section] as! String
        return view;
    }
    
    // 设置section的间隔距离
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 60
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 2
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        
        let cell=tableView.dequeueReusableCellWithIdentifier(harvardBaseInfoCellTag, forIndexPath: indexPath)
            as? UITableViewCell
        
        
        println("---------tabview \(indexPath.row)  \(indexPath.section)");
        //        var lable=cell!.viewWithTag(TAG_CELL_LABLE) as? UILabel
        //         lable.text=(data!.allValues[indexPath.section] as! NSArray).objectAtIndex(indexPath.row) as! String
        var label=cell?.textLabel?.text=(selfData!.allValues[indexPath.section] as! NSArray).objectAtIndex(indexPath.row) as! String;
        //
        if(indexPath.section == 0)
        {
            if(indexPath.row == 0)
            {
                if(harvardExamModel.menstrualHistory.firstPeriodAga == nil)
                {
                    harvardExamModel.menstrualHistory.firstPeriodAga = menarche_days[0];
                }
                cell?.detailTextLabel?.text = "\(harvardExamModel.menstrualHistory.firstPeriodAga)";
            }
            else if(indexPath.row == 1)
            {
                if(harvardExamModel.menstrualHistory.menopauseStatus == nil)
                {
                    cell?.detailTextLabel?.text = "Peri";
                }
                else if(harvardExamModel.menstrualHistory.menopauseStatus == MenopauseStatus.Peri)
                {
                    cell?.detailTextLabel?.text = "Peri";
                }
                else if(harvardExamModel.menstrualHistory.menopauseStatus == MenopauseStatus.Post)
                {
                    cell?.detailTextLabel?.text = "Post";
                }
                else if(harvardExamModel.menstrualHistory.menopauseStatus == MenopauseStatus.Post)
                {
                    cell?.detailTextLabel?.text = "Pre";
                }
                else if(harvardExamModel.menstrualHistory.menopauseStatus == MenopauseStatus.Post)
                {
                    cell?.detailTextLabel?.text = "Unknown"
                }
            }
            else if(indexPath.row == 2)
            {
                // let ovary_isremove_temp=["No","Yes","Unknown"]
                if(harvardExamModel.menstrualHistory.isBothovariesRemoved == nil)
                {
                    cell?.detailTextLabel?.text = "No"
                }
                else if(harvardExamModel.menstrualHistory.isBothovariesRemoved == YesNoUnknown.No)
                {
                    cell?.detailTextLabel?.text = "No"
                }
                else if(harvardExamModel.menstrualHistory.isBothovariesRemoved == YesNoUnknown.Yes)
                {
                    cell?.detailTextLabel?.text = "Yes"
                }
                else if(harvardExamModel.menstrualHistory.isBothovariesRemoved == YesNoUnknown.Unknown)
                {
                    cell?.detailTextLabel?.text = "Unknown"
                }
            }
            else if(indexPath.row == 3)
            {
                if(harvardExamModel.menstrualHistory.ovaryRemovalAge == nil)
                {
                    harvardExamModel.menstrualHistory.ovaryRemovalAge = ovary_remove_age[0];
                }
                cell?.detailTextLabel?.text = "\(harvardExamModel.menstrualHistory.ovaryRemovalAge)"
            }

        }
        if(indexPath.section == 1)
        {
            if(indexPath.row == 0)
            {
              
                if(harvardExamModel.ethnicity.isGrandparentsOfJewishDescent == nil)
                {
                    cell?.detailTextLabel?.text = descent_temp[0];
                }
                else if(harvardExamModel.ethnicity.isGrandparentsOfJewishDescent == CommonAnswer.No)
                {
                    cell?.detailTextLabel?.text = "No";
                }
                else if(harvardExamModel.ethnicity.isGrandparentsOfJewishDescent == CommonAnswer.NotSure)
                {
                    cell?.detailTextLabel?.text = "Not Sure";
                }
                else if(harvardExamModel.ethnicity.isGrandparentsOfJewishDescent == CommonAnswer.PreferNotToAnswer)
                {
                    cell?.detailTextLabel?.text = "Prefer Not To Answer";
                }
                else if(harvardExamModel.ethnicity.isGrandparentsOfJewishDescent == CommonAnswer.Yes)
                {
                    cell?.detailTextLabel?.text = "Yes";
                }
            }
            else if(indexPath.row == 1)
            {
                //        let family_bg_temp=["African American Or Black","American Indian Aleutian Eskimo","Asion Or Pacific Islander","Caribbean West Indian","Caucasian Or White","Other"]
                if(harvardExamModel.ethnicity.racialBackground == nil)
                {
                    cell?.detailTextLabel?.text = family_bg_temp[0]
                }
                else if(harvardExamModel.ethnicity.racialBackground == Ethnicity.RacialBackground.AfricanAmericanOrBlack)
                {
                    cell?.detailTextLabel?.text = "frican American Or Black"
                }
                else if(harvardExamModel.ethnicity.racialBackground == Ethnicity.RacialBackground.American_Indian_Aleutian_Eskimo)
                {
                    cell?.detailTextLabel?.text = "American Indian Aleutian Eskimo"
                }
                else if(harvardExamModel.ethnicity.racialBackground == Ethnicity.RacialBackground.AsionOrPacificIslander)
                {
                    cell?.detailTextLabel?.text = "Asion Or Pacific Islander"
                }
                else if(harvardExamModel.ethnicity.racialBackground == Ethnicity.RacialBackground.Caribbean_WestIndian)
                {
                    cell?.detailTextLabel?.text = "Caribbean West Indian"
                }
                else if(harvardExamModel.ethnicity.racialBackground == Ethnicity.RacialBackground.CaucasianOrWhite)
                {
                    cell?.detailTextLabel?.text = family_bg_temp[4]
                }
                else if(harvardExamModel.ethnicity.racialBackground == Ethnicity.RacialBackground.Other)
                {
                    cell?.detailTextLabel?.text = family_bg_temp[5]
                }
                
                //cell?.detailTextLabel?.text = "\(harvardExamModel.ethnicity.racialBackground)"
            }
        }

        
        //cell?.detailTextLabel?.text=String(indexPath.row)
        
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
            return "\(self.menopause_info_temp[row] )"
        } else if(pickerView.tag == 2){
            return "\(self.ovary_isremove_temp[row])"
        }
        else if(pickerView.tag==3){
            return "\(self.ovary_remove_age[row])"
        }
        else if(pickerView.tag==4){
            return "\(self.descent_temp[row])"
        }
        else if(pickerView.tag==5){
            return "\(self.family_bg_temp[row])"
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
                println("you selected the name: \(self.descent[row])")
                harvardExamModel.ethnicity.isGrandparentsOfJewishDescent = self.descent[row]
            }
            else if(pickerView.tag == 5)
            {
                println("you selected the name: \(self.family_bg[row])")
                harvardExamModel.ethnicity.racialBackground = self.family_bg[row]
            }
    }
}

extension HarvardCheckBaseInfo3VC:AlertPickerViewControllerDelegate{
    func didSelect(){
        println("didSelect")
        tableBaseInfo3.reloadData();
    }
    func didCancel()
    {
        println("didCancel")
    }
}