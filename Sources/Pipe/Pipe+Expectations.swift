//
//  Pipe+Expectations.swift
//  Sample
//
//  Created by Alex Kozin on 03.12.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import Foundation

extension Pipe {
    
    final class Expectations {
        
        static let defaultErrorHandler: (Error)->() = { error in
            print("Error in Pipe \n \(error.localizedDescription)")
        }
        
        var every = [String: [Any]]()
        var once = [String: [Any]]()
        var `while` = [String: [Any]]()
        
        private weak var pipe: Pipe!
        
        init(_ pipe: Pipe) {
            self.pipe = pipe
            
            //Add default error handler
            event(.every(Expectations.defaultErrorHandler))
        }
        
        //Add expectation of event to pipe
        func event<T>(_ event: Event<T>) {
            let object: T? = pipe.get()
            
            switch event {
                case ._every(let key, let isExclusive, let handler):
                    //Make true if object exist
                    if let object = object {
                        handler(object)
                    }
                    
                    //And store
                    var expectations: [Any]
                    if isExclusive {
                        expectations = [handler]
                    } else {
                        expectations = every[key, default: [Any]()]
                        expectations.append(handler)
                    }
                    every[key] = expectations
                    
                case ._once(let key, let isExclusive, let handler):
                    
                    //Make true if object exist
                    if let object = object {
                        handler(object)
                    } else {
                        //Otherwise store
                        var expectations: [Any]
                        if isExclusive {
                            expectations = [handler]
                        } else {
                            expectations = once[key, default: [Any]()]
                            expectations.append(handler)
                        }
                        once[key] = expectations
                    }
                    
                case ._while(let key, let isExclusive, let handler):
                    //Make true if object exist
                    if let object = object {
                        if handler(object) {
                            //Don't store if condition 'true'
                            return
                        }
                    }
                    
                    //Otherwise store
                    var expectations: [Any]
                    if isExclusive {
                        expectations = [handler]
                    } else {
                        expectations = `while`[key, default: [Any]()]
                        expectations.append(handler)
                    }
                    
                    `while`[key] = expectations
            }
        }
        
        //Meet expectation
        func come<T>(for object: T?, with key: String = T.self|, error: Error? = nil) {
            //Check for error first
            if let error = error {
                come(for: error)
                return
            }
            
            guard let object = object else {
                fatalError("Unexpected behaviour for nil error: object is nil too")
            }
            
            pipe.put(object)
            
            //Make true .every expectations
            (every[key] as? [(T)->()])?.forEach {
                $0(object)
            } 
            
            //Make true .once expectations
            //And remove them
            if let forObject = once[key] as? [(T)->()] {
                forObject.forEach {
                    $0(object)
                }
                
                self.once.removeValue(forKey: key)
            }
            
            //Make true while expectations
            //And remove them if returns 'true'
            if let forObject = `while`[key] as? [(T)->(Bool)] {
                forObject.forEach {
                    if $0(object) {
                        self.while.removeValue(forKey: key)
                    }
                }
   
            }
            
        }
        
        //Merge expectations of two pipes
        func merge(with: Expectations?) {
            guard let new = with else {
                return
            }
            
            every.merge(new.every) {
                $0 + $1
            }
            
            once.merge(new.once) {
                $0 + $1
            }
            
            `while`.merge(new.while) {
                $0 + $1
            }
        }
    
    }
    
}

extension Pipe.Expectations: CustomStringConvertible {
    
    var description: String {
        ""
    }
}

enum Event<T> {
    
    case _once(key: String, exclusive: Bool, handler: (T)->())
    case _every(key: String, exclusive: Bool, handler: (T)->())
    case _while(key: String, exclusive: Bool, handler: (T)->(Bool))
    
    //Once
    static func once(_ key: String? = nil, exclusive: Bool = false, handler: @escaping (T)->()) -> Self {
        ._once(key: key ?? String(describing: T.self), exclusive: exclusive, handler: handler)
    }
    
    static func once(_ handler: @escaping (T)->()) -> Self {
        once(handler: handler)
    }
    
    //Every
    static func every(_ key: String? = nil, exclusive: Bool = false, handler: @escaping (T)->()) -> Self {
        ._every(key: key ?? String(describing: T.self), exclusive: exclusive, handler: handler)
    }
    
    static func every(_ handler: @escaping (T)->()) -> Self {
        every(handler: handler)
    }
    
    //While
    static func `while`(_ key: String? = nil, exclusive: Bool = false, handler: @escaping (T)->(Bool)) -> Self {
        ._while(key: key ?? String(describing: T.self), exclusive: exclusive , handler: handler)
    }
    
    static func `while`(_ handler: @escaping (T)->(Bool)) -> Self {
        .while(handler: handler)
    }
    
}
    
@discardableResult
func |<T, P: Pipable>(of: P, event: Event<T>) -> P {
    of.pipe().expect.event(event)
    return of
}
