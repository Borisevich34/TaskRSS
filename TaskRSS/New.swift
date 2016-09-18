//
//  File.swift
//  TaskRSS
//
//  Created by MacBook on 17.09.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import Foundation
import CoreData


class New: NSManagedObject {
    
//    - заголовок новости
//    - дата публикации
//    - иконка новости(если есть)
//    - краткое описание новости(с динамической высотой ячейки) // этого я делать конечно же не буду
    
//    - Заголовок
//    - Картинка
//    - Дата публикации
//    - Текст новости
    
    @NSManaged var title: String?
    @NSManaged var date: NSDate?
    @NSManaged var image: String?
    @NSManaged var newDescription: String?
    
}