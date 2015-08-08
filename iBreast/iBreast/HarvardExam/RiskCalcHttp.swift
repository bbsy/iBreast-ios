//
//  RiskCalcHttp.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/8/1.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

func toJSONString(dict:NSDictionary!)->NSString{
    
    var error:NSError
    var data = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error:nil)
    var strJson=NSString(data: data!, encoding: NSUTF8StringEncoding)
    
    println(strJson)
    return strJson!
    
}

func arrayo2JSONString(array:NSMutableArray!)->NSString{
    
    var data = NSJSONSerialization.dataWithJSONObject(array, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
    var strJson=NSString(data: data!, encoding: NSUTF8StringEncoding)
    
    println(strJson)
    return strJson!
    
}

var riskCalculation = NSMutableDictionary()

var  riskCalc = RiskCalcHttp()

class RiskCalcHttp: NSObject {
    
    
    class var sharedInstance :RiskCalcHttp{
    
        return riskCalc
    }

    
    func wrapFamilyInfo(mHarvardCheckModel:HarvardCheckModel){
        
         var familyInfos=mHarvardCheckModel.familyInfos
        
         var familyDic = NSMutableArray()
        
        for member in familyInfos {
            
            
           var item  = NSMutableDictionary()
            
            var family = NSMutableDictionary()
            
            var cancers = NSMutableArray()
            for  i in 0...member._cancerName!.count-1{
                var cancerAndAge = NSMutableDictionary()
                
                var c = member._cancerName![i]
                var age = member._age![i]
                
                cancerAndAge.setObject(c, forKey:"cancer" )
                cancerAndAge.setObject(age, forKey:"age" )
                
                cancers.addObject(cancerAndAge)
            }
            
            item.setObject(cancers, forKey: "cancers")
            item.setObject(member._bloodline, forKey: "bloodline")
            item.setObject(member._relationship, forKey: "relationship")
            
           

            
            familyDic.addObject(item)
            
         }
        
        riskCalculation.setObject(familyDic, forKey: "familyInfo")
        
        println(familyDic)
    }
    
    func wrapPhysicalData(model:PhysicalDataModel){
        
        var item  = NSMutableDictionary()
        item.setObject(model.age, forKey: "age")
        item.setObject(model.gender, forKey: "gender")
        item.setObject(model.weight, forKey: "weight")
        item.setObject(model.height, forKey: "height")
        
        
        riskCalculation.setObject(item, forKey: "PhysicalData")
        
         println(item)
        
        
        
    }
    
    func wrapBiopsies(model:Biopsies){
        
        var item  = NSMutableDictionary()
        var atypiaStr = "NAOrUnknow"
        
        if model.atypia == Biopsies.Atypia.BenignBreastCondition{
             atypiaStr = "BenignBreastCondition"
        }
        else if(model.atypia == Biopsies.Atypia.AtypicalHyperplasia){
             atypiaStr = "AtypicalHyperplasia"
        }
        else if(model.atypia == Biopsies.Atypia.Hyperplasia_NoAtypia){
            atypiaStr = "Hyperplasia_NoAtypia"
        }
        else if(model.atypia == Biopsies.Atypia.LCIS){
             atypiaStr = "LCIS"
        }
        else if(model.atypia == Biopsies.Atypia.NAOrUnknow){
             atypiaStr = "NAOrUnknow"
        }
        item.setObject(atypiaStr, forKey:"atypia")
        item.setObject(model.biopsiesNum, forKey: "biopsiesNum")

        
        riskCalculation.setObject(item, forKey: "Biopsies")


        println(item)
    }
    
    func wrapChildbirthHistory(model:ChildbirthHistory){
        var item  = NSMutableDictionary()
        item.setObject(model.pregnanciesNum, forKey:"pregnanciesNum")
        item.setObject(model.ageAtFirstLiveBirth, forKey: "ageAtFirstLiveBirth")

        
        riskCalculation.setObject(item, forKey: "ChildbirthHistory")
        
        
        println(item)
    }
    
    func wrapMenstrualHistory(model:MenstrualHistory){
          var item  = NSMutableDictionary()
        
        var menstrual="Peri"
        
        item.setObject(model.firstPeriodAga, forKey:"firstPeriodAga")
        
        if(model.menopauseStatus == nil)
        {
            menstrual = "Peri";
        }
        else if(model.menopauseStatus == MenopauseStatus.Peri)
        {
           menstrual = "Peri";
        }
        else if(model.menopauseStatus == MenopauseStatus.Post)
        {
            menstrual = "Post";
        }
        else if(model.menopauseStatus == MenopauseStatus.Post)
        {
            menstrual = "Pre";
        }
        else if(model.menopauseStatus == MenopauseStatus.Post)
        {
            menstrual = "Unknown"
        }
        
        var ovaries = "Yes"
        
        if(model.isBothovariesRemoved == YesNoUnknown.Yes){
            ovaries = "Yes"
        }
        else  if(model.isBothovariesRemoved == YesNoUnknown.No){
            ovaries = "No"
        }
        if(model.isBothovariesRemoved == YesNoUnknown.Unknown){
            ovaries = "Unknown"
        }

        
        
        item.setObject(menstrual , forKey: "menopauseStatus")

        item.setObject(ovaries, forKey: "isBothovariesRemoved")
      
        item.setObject(model.ovaryRemovalAge, forKey: "ovaryRemovalAge")
        
        
        
        riskCalculation.setObject(item, forKey: "MenstrualHistory")
        
    }
    
    
    func wrapEthnicity(model:Ethnicity){
        
        var item  = NSMutableDictionary()
        
        var hispanic = "Yes"
        
        if(model.Hispanic == nil)
        {
            hispanic = "Yes";
        }
        else if(model.Hispanic == CommonAnswer.Yes)
        {
            hispanic = "Yes";
        }
        else if(model.Hispanic == CommonAnswer.No)
        {
            hispanic = "No";
        }
        else if(model.Hispanic == CommonAnswer.NotSure)
        {
            hispanic = "NotSure";
        }
        else if(model.Hispanic == CommonAnswer.PreferNotToAnswer)
        {
            hispanic = "PreferNotToAnswer"
        }
        
        var isGrandparentsOfJewishDescent = "Yes"

        if(model.isGrandparentsOfJewishDescent == nil)
        {
            isGrandparentsOfJewishDescent = "Yes";
        }
        else if(model.isGrandparentsOfJewishDescent == CommonAnswer.Yes)
        {
            isGrandparentsOfJewishDescent = "Yes";
        }
        else if(model.isGrandparentsOfJewishDescent == CommonAnswer.No)
        {
            isGrandparentsOfJewishDescent = "No";
        }
        else if(model.isGrandparentsOfJewishDescent == CommonAnswer.NotSure)
        {
            isGrandparentsOfJewishDescent = "NotSure";
        }
        else if(model.isGrandparentsOfJewishDescent == CommonAnswer.PreferNotToAnswer)
        {
            isGrandparentsOfJewishDescent = "PreferNotToAnswer"
        }

        
        var racialBackground = "AfricanAmericanOrBlack"
        if(model.racialBackground == nil)
        {
            isGrandparentsOfJewishDescent = "AfricanAmericanOrBlack";
        }
        else if(model.racialBackground == Ethnicity.RacialBackground.AfricanAmericanOrBlack)
        {
            racialBackground = "AfricanAmericanOrBlack";
        }
        else if(model.racialBackground == Ethnicity.RacialBackground.American_Indian_Aleutian_Eskimo)
        {
            racialBackground = "American_Indian_Aleutian_Eskimo";
        }
        else if(model.racialBackground == Ethnicity.RacialBackground.AsionOrPacificIslander)
        {
            racialBackground = "AsionOrPacificIslander";
        }
        else if(model.racialBackground == Ethnicity.RacialBackground.Caribbean_WestIndian)
        {
            racialBackground = "PreferNotToAnswer"
        }
        else if(model.racialBackground == Ethnicity.RacialBackground.CaucasianOrWhite)
        {
            racialBackground = "CaucasianOrWhite";
        }
        else if(model.racialBackground == Ethnicity.RacialBackground.Other)
        {
            racialBackground = "Other";
        }
        
        
        item.setObject(hispanic , forKey: "hispanic")
        
        item.setObject(isGrandparentsOfJewishDescent, forKey: "isGrandparentsOfJewishDescent")
        
        item.setObject(racialBackground, forKey: "racialBackground")
        
        
        
        riskCalculation.setObject(item, forKey: "Ethnicity")
        
        println(item)

    }
    
    func wrapHormoneReplacementTherapy(model:HormoneReplacementTherapy){
        var item  = NSMutableDictionary()
        
        
        var everUsedHormones = "No_Never"
        
        if(model.everUsedHormones == HormoneReplacementTherapy.UsedHormones.No_Never){
            everUsedHormones = "No_Never"
        }
        else if(model.everUsedHormones == HormoneReplacementTherapy.UsedHormones.Not_Sure){
               everUsedHormones = "Not_Sure"
        }
         else if(model.everUsedHormones == HormoneReplacementTherapy.UsedHormones.Yes_Currently){
                everUsedHormones = "Yes_Currently"
        }
        else if(model.everUsedHormones == HormoneReplacementTherapy.UsedHormones.Yes_InThePast){
            everUsedHormones = "Yes_InThePast"
        }
        
        var combined = "Yes"
        
        if(model.combined == YesOrNo.Yes){
            everUsedHormones = "Yes"
        }
        else if(model.combined == YesOrNo.No){
            everUsedHormones = "No"
        }

        
        
        item.setObject(everUsedHormones , forKey: "everUsedHormones")
        
        item.setObject(combined, forKey: "combined")
        
        item.setObject(200, forKey: "yearsTaken")

        riskCalculation.setObject(item, forKey: "HormoneReplacementTherapy")
        
    }
    
    func printRisk(){
        toJSONString(riskCalculation)
    }
    
}
