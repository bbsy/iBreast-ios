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
    
    
    func initData(){
        
        for var i=0; i<2;++i{
            
            var family=HarvardCheckFamilyInfo(relationship: "self",bloodline: "mother",cancerName: "brain",age: 20)
             familyInfos.append(family)
            
            
            for var j=0; j<3; ++j {
                 family.addCancer( "brain",age: 25)
            }
            
            
            
        }
        
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
        var _relationship:String?
        
        var _bloodline:String
        var _cancerName:[String]?
        var _age:[Int]?
        
        init(relationship:String,bloodline:String,cancerName:String,age:Int){
           
            _relationship=relationship
          
            _bloodline=bloodline
           
            _cancerName=[String]()
            _cancerName?.append(cancerName)
            _age=[Int]()
            _age?.append(age)
            ++_cancerCount

        }
        
        func addCancer(cancerName:String ,age:Int){
            
           _cancerName?.append(cancerName)
            
            _age?.append(age)
            ++_cancerCount
            
        }

//
        
        
        
    }
   
}
