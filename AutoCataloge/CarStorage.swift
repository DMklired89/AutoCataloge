//
//  CarStorage.swift
//  AutoCataloge
//
//  Created by Dmitry on 02/04/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation

class CarStorage {
    private lazy var fileURL: URL = {
        let directoryURL =  FileManager.default.homeDirectoryForCurrentUser
        return directoryURL.appendingPathComponent("carsData")
    }()
    
    private var cars: [Car] = []
    
    init () {
        load()
    }
    
    func getCarList() -> [Car] {
        return self.cars
    }
    
    func append(car: Car) -> Bool {
        assert(!cars.contains(where: {car === $0}))
        cars.append(car)
        return save()
    }
    func remove(car: Car) -> Bool {
        assert(cars.contains(where: {car === $0}))
        cars.removeAll(where: {$0 === car})
        return save()
    }
    func modify(oldCar: Car, newCar: Car) -> Bool {
        assert(cars.contains(where: {oldCar === $0}))
        if let index = cars.firstIndex (where: {oldCar === $0 }) {
            cars[index] = newCar
            return save()
        }
        return false
    }
    
    private func save() ->  Bool {
        //        let directoryURL =  FileManager.default.homeDirectoryForCurrentUser
        //        let fileURL = directoryURL.appendingPathComponent("carsData")
        
        if let data: Data = try? JSONEncoder().encode(cars) {
            return nil != (try? data.write(to: fileURL))
        }
        return false
    }
    
    @discardableResult
    
    private func load() ->  Bool {
        do {
            let data = try Data (contentsOf: fileURL)
            cars = try JSONDecoder().decode([Car].self, from: data)
            return true
        }
        catch {
            return false
        }
    }
}
