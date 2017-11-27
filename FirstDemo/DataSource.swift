//
//  DataSource.swift
//  FirstDemo
//
//  Created by 周彥宏 on 2017/3/13.
//  Copyright © 2017年 周彥宏. All rights reserved.
//

import UIKit

class DataSource: NSObject {
    
    //sandbox 路徑 如果沒有則建立檔案
    let documentsFilePath = "\(NSHomeDirectory())/Documents/Data.plist";
    
    
    override init(){
        super.init();
        let fileManager = FileManager.default;
        print(documentsFilePath);
        
        if fileManager.fileExists(atPath: documentsFilePath) == false{
            if (fileManager.createFile(atPath: documentsFilePath, contents: nil, attributes: nil) == false){
                print("建立失敗");
            }else{
                print("建立成功");

            }
        }
        
    }
    
    
    //初次沒有生成檔案會先判斷Empty，之後只要document有檔案，不管有沒有值,都只會判斷NotEmpty
    
    
    var names:[String]{
        get{
            let nameNDictionary = NSDictionary(contentsOfFile: documentsFilePath);
            if nameNDictionary == nil{
                print("isEmpty");
                return [];
            }else{
                print("isNotEmpty");
                return nameNDictionary!["names"] as! [String];
            }
        }
        set(newValue){
            let newDic = ["names":newValue] as NSDictionary;
            newDic.write(toFile: documentsFilePath, atomically: true);
        }
    }
    
    

    
    //for searchController
     func filterName(_ letter:String) -> [String]{
        let filterNames = names.filter(){
            (member:String) -> Bool in
            let result = member.range(of: letter, options: .caseInsensitive);
            return (result != nil);
        }
        return filterNames;

    }
    
    
}
