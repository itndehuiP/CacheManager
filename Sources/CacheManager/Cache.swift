//
//  File.swift
//  
//
//  Created by Guerson on 2020-10-24.
//

import Foundation

public final class Cache<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
    
    public func insert(_ value: Value, forKey key: Key) {
        let entry = Entry(value: value)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }

    public func value(forKey key: Key) -> Value? {
        let entry = wrapped.object(forKey: WrappedKey(key))
        return entry?.value
    }

    public func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
    
    public subscript(key: Key) -> Value? {
         get { return value(forKey: key) }
         set {
             guard let value = newValue else {
                 // If nil was assigned using our subscript,
                 // then we remove any value for that key:
                 removeValue(forKey: key)
                 return
             }

             insert(value, forKey: key)
         }
     }
    
    public init() {}
}
//MARK: Entry
private extension Cache {
    final class Entry {
        let value: Value
        
        init(value: Value) {
            self.value = value
        }
    }
}
//MARK: NSObject
private extension Cache {
    final class WrappedKey: NSObject {
        let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        override public var hash: Int { return key.hashValue }

        override public func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }

            return value.key == key
        }
    }
}

