//
//  Commands.swift
//  AutoCataloge
//
//  Created by Dmitry on 07/04/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation

class Commands {
    var carStorage = CarStorage()
    func consoleCommands() {
        print("""
            Автокаталог.
            Список команд:
            add - добавить новый автомобиль
            list - вывести список автомобилей
            delete - удалить автомобиль из списка
            update - обновить данные об автомобиле
            exit - завершить программу
            """)
        
        while true {
       
        let selectedCommand = readLine()
        switch selectedCommand {
        case "add": addCar()
        case "list": printCarList()
        case "delete": deleteCar()
        case "update": updateCar()
        case "exit": return
        default:
            print("CRASHED!!!")
            
            }
            
        }
        
    }
    
    func printCarList() {
        var carNumber = 0
        let cars = carStorage.getCarList()
        print("Cписок имеющихся автомобилей:")
        for car in cars {
            var printString = "\(carNumber): \n "
            for property in Car.Property.allValues {
                printString.append("\(property): \(car[property])\n ")
                
            }
            print(printString)
            carNumber += 1
            
        }
    }
    
    func addCar() {
        let car = Car()
        for property in Car.Property.allValues {
            print("Write \(property.rawValue):")
            car[property] = readLine()!
            
        }
        if carStorage.append(car: car) {
            print("Автомобиль добавлен")
            
        }
        else {
            print("Не удалось добавить!")
            
        }
        
    }
    
    func deleteCar() {
        let cars = carStorage.getCarList()
        print("Выберете из списка номер автомобиля для удаления.")
        printCarList()
        while true {
            // guard - continue - цикл будет запущен пока не будет введен Int
            guard let carAtList = Int(readLine()!) else {
                print("Введите корректную команду!")
                continue }
            if  carAtList < cars.count, carAtList >= 0 {
                if carStorage.remove(car: cars[carAtList]) {
                    print("Автомобиль под номером \(carAtList) удален")
                    
                }
                else {
                    print("Не удалось удалить!")
                }
                break
            }
            print("Автомобиля с номером \(carAtList) нет в списке!")
            break
        }
    }
    
    
    func updateCar() {
        
        let cars = carStorage.getCarList()
        print("Введите номер автомобиля, данные которого нужно изменить:")
        printCarList()
        while true {
            guard let index = Int(readLine()!) else {
                print("Введите корректную команду!")
                continue }
            if index >= 0 && index < cars.count {
                let oldCar = cars[index]
                let newCar = Car()
                for property in Car.Property.allValues {
                    print("\(property.rawValue) (old value: \(oldCar[property]))")
                    
                    if let newProperty = readLine(), !newProperty.isEmpty {
                        newCar[property] = newProperty
                        
                    } else {
                        newCar[property] = oldCar[property]
                        
                    }
                    
                }
                if carStorage.modify(oldCar: oldCar, newCar: newCar) {
                    print("Данные об автомобиле изменены")
                    
                } else {
                    print("Не удалось изменить данные!")
                    
                }
                
            }
            break
            
        }
        
    }
    
}







