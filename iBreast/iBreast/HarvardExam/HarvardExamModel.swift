//
//  HarvardExamModel.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/20.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

enum CommonAnswer{
    case Yes
    case No
    case NotSure
    case PreferNotToAnswer
}
enum YesOrNo{
    case Yes
    case No
}
enum YesNoUnknown{
    case Yes
    case No
    case Unknown
}
enum MenopauseStatus{
    case Peri
    case Post
    case Pre
    case Unknown
}


typealias HarvardExamFamilyHistory = HarvardCheckModel.HarvardCheckFamilyInfo
var harvardExamModel:HarvardExamModel = HarvardExamModel()

class HarvardExamModel: NSObject {
    
    var familyInfos = [HarvardExamFamilyHistory]()
    var physicalDataModel:PhysicalDataModel!
    var menstrualHistory:MenstrualHistory!
    var ethnicity:Ethnicity!
    var hormoneReplacementTherapy:HormoneReplacementTherapy!
    var childbirthHistory:ChildbirthHistory!
    var biopsies:Biopsies!
    

}

//身体参数
class PhysicalDataModel{
    
    //性别
    var gender:Int!
    //年龄
    var age:Int!
    //体重
    var weight:Int!
    //身高
    var height:Int!
    
}

//经期历史
class MenstrualHistory{
    
    
    //第一次月经时间
    var firstPeriodAga:Int!
    //绝经情况
    var menopauseStatus:MenopauseStatus!
    //是否双侧卵巢移除
    var isBothovariesRemoved:YesNoUnknown!
    //卵巢移除年纪
    var ovaryRemovalAge:Int!
    
}

//种族
class Ethnicity{
    
   
    //种族背景
    enum RacialBackground{
        case AfricanAmericanOrBlack
        case American_Indian_Aleutian_Eskimo
        case AsionOrPacificIslander
        case Caribbean_WestIndian
        case CaucasianOrWhite
        case Other
    }
    
    
    //祖先是否有犹太血统
    var isGrandparentsOfJewishDescent:CommonAnswer!
    //种族背景
    var racialBackground:RacialBackground!
    //是否西班牙人
    var Hispanic:CommonAnswer!
    
    
}

//激素使用情况
class 	HormoneReplacementTherapy{
    enum UsedHormones{
    
        case No_Never
        case Not_Sure
        case Yes_Currently
        case Yes_InThePast
        
      
    }
    //是否使用过激素
    var everUsedHormones:UsedHormones!
    //组合使用
    var combined:YesOrNo!
    //使用年限
    var yearsTaken:Int!
    
    var intendedDuration:Int!
    var yearsSinceTaken:Int!
    
}
//孩子生育历史
class ChildbirthHistory{
    //怀孕次数
    var pregnanciesNum:Int!
    //第一个孩子出生年纪
    var ageAtFirstLiveBirth:Int!
    
}
//活体组织检查
class Biopsies{
    
    enum Atypia{
        case NAOrUnknow
        case BenignBreastCondition
        case Hyperplasia_NoAtypia
        case AtypicalHyperplasia
        case LCIS
    }
    //检查次数
    var biopsiesNum:Int!
    //检查报告
    var atypia:Atypia!
    
}
