//
//  HarvardCheckModel.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/9.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class HarvardCheckModel: NSObject {
    
    var familyInfos=[HarvardCheckFamilyInfo]()
    var relationShips = ["Self","Mother","Father","Grandmother","Grandfather","Grandmother","Grandfather","Aunt","Brotser","Cousin","Cousin(Female)","Cousin(Male)","Daughter","Nephew","Niece","Sister","Son","Uncle","Unknow"];
    var bloodLines = ["Maternal","Paternal","Both"];
    
    // this list for self
    var cancersForSelf = ["Brain Cancer","Breast Cancer","Cervical Cancer","Colon or Rectal Cancer","Hodgkins Lymphoma","Kidney or Bladder Cancer","Leukemia","Liver Cancer","Lung Cancer","Lymphoma(Non-Hodgkins)","Melanoma","Ovarian Cancer","Pancreatic Cancer","Prostate Cancer","Sarcoma","Stomach Cancer","Thyroid Cancer","Uterine Cancer","Other"];
    
    // this list for maternal
    var cancersForMaternal = ["Brain Cancer","Breast Cancer","Cervical Cancer","Colon or Rectal Cancer","Hodgkins Lymphoma","Kidney or Bladder Cancer","Leukemia","Liver Cancer","Lung Cancer","Lymphoma(Non-Hodgkins)","Melanoma","Ovarian Cancer","Pancreatic Cancer","Sarcoma","Stomach Cancer","Thyroid Cancer","Uterine Cancer","Other"];
    
    // this list for paternal
    var cancersForPaternal = ["Brain Cancer","Breast Cancer","Colon or Rectal Cancer","Hodgkins Lymphoma","Kidney or Bladder Cancer","Leukemia","Liver Cancer","Lung Cancer","Lymphoma(Non-Hodgkins)","Melanoma","Pancreatic Cancer","Prostate Cancer","Sarcoma","Stomach Cancer","Thyroid Cancer","Uterine Cancer","Other"];
    
    var age:[Int]=[Int]();

    
    func initData(){
        
        for var j=1;j<=105;j++
        {
            age.append(j);
        }
        
        // self
        var family1 = HarvardCheckFamilyInfo(relationship: relationShips[0], bloodline: bloodLines[2], cancerName: cancersForSelf[0], age: age[25]);
        //family1.addCancer( "brain",age: 25)
        
        // mather
        var family2 = HarvardCheckFamilyInfo(relationship: relationShips[1], bloodline: bloodLines[0], cancerName: cancersForSelf[0], age: age[25]);
        //family2.addCancer( "brain",age: 25)

        // father
        var family3 = HarvardCheckFamilyInfo(relationship: relationShips[2], bloodline: bloodLines[1], cancerName: cancersForSelf[0], age: age[25]);
        //family3.addCancer( "brain",age: 25)

        // grandmother
        var family4 = HarvardCheckFamilyInfo(relationship: relationShips[3], bloodline: bloodLines[0], cancerName: cancersForSelf[0], age: age[25]);
        //family4.addCancer( "brain",age: 25)

        // grandfather
        var family5 = HarvardCheckFamilyInfo(relationship: relationShips[4], bloodline: bloodLines[0], cancerName: cancersForSelf[0], age: age[25]);
        //family5.addCancer( "brain",age: 25)

        // grandmother (p)
        var family6 = HarvardCheckFamilyInfo(relationship: relationShips[5], bloodline: bloodLines[1], cancerName: cancersForSelf[0], age: age[25]);
        //family6.addCancer( "brain",age: 25)

        // grandfather (p)
        var family7 = HarvardCheckFamilyInfo(relationship: relationShips[6], bloodline: bloodLines[1], cancerName: cancersForSelf[0], age: age[25]);
        //family7.addCancer( "brain",age: 25)

        familyInfos.append(family1)
        familyInfos.append(family2)
        familyInfos.append(family3)
        familyInfos.append(family4)
        familyInfos.append(family5)
        familyInfos.append(family6)
        familyInfos.append(family7)

//        for var i=0; i<7;++i{
        
//            var family = HarvardCheckFamilyInfo(relationship: relationShips[0], bloodline: bloodLines[2], cancerName: cancersForSelf[0], age: age[25]);
//            family.addCancer( "brain",age: 25)
//            var family=HarvardCheckFamilyInfo(relationship: "self",bloodline: "mother",cancerName: "brain",age: 20)
//             familyInfos.append(family)
//            
//            
//            for var j=0; j<3; ++j {
//                 family.addCancer( "brain",age: 25)
//            }
//            
//            
//            
//        }
        
    }
    
    
    
    
    
    func addNewFamilyMember(_relationship:String,_bloodline:String,_cancerName:String,_age:Int){
    
        var member=HarvardCheckFamilyInfo( relationship: _relationship, bloodline: _bloodline, cancerName: _cancerName,age: _age)
        
        familyInfos.append(member)

        member._cancerCount+=1
    }
    
    func addCancerWithRelationship(relationship:String,cancerName:String,age:Int)->Bool{
        for relation in familyInfos{
            if(relation._relationship==relationship){
                relation._cancerName?.append(cancerName)
                relation._age?.append(age)
               
                return true
            }
        }
        return false
    }
    
    
    
    
    class HarvardCheckFamilyInfo{
        
        
        var _cancerCount:Int=0
        var _relationship:String!
        
        var _bloodline:String!
        var _cancerName:[String]!
        var _age:[Int]!
        
        init(relationship:String,bloodline:String,cancerName:String,age:Int){
           
            _relationship=relationship
          
            _bloodline=bloodline
           
            _cancerName=[String]()
            _cancerName?.append(cancerName)
            _age=[Int]()
            _age?.append(age)
            ++_cancerCount
            ++_cancerCount
             println("_cancerCount:\(_cancerCount)")

        }
        
        func addCancer(cancerName:String ,age:Int){
            
           _cancerName?.append(cancerName)
            
            _age?.append(age)
            ++_cancerCount
            println("add cancaeName\(cancerName)")
            
        }

//
        
        
        
    }
   
}
