//
//  Validation.swift
//  Swiftz-Validation
//
//  Created by Ricardo Pallás on 09/09/2017.
//  Copyright © 2017 Ricardo Pallas. All rights reserved.
//

import Foundation

public enum Validation<L,R> {
    
    case Failure(L)
    case Success(R)
    
    /// Returns the value of `Success` if it exists otherwise nil.
    public var success : R? {
        switch self {
        case .Success(let r): return r
        default: return nil
        }
    }
    
    /// Returns the value of `Failure` if it exists otherwise nil.
    public var failure : L? {
        switch self {
        case .Failure(let l): return l
        default: return nil
        }
    }
    
}

extension Validation {  //Functor
    public typealias B = Any
    public typealias FB = Validation<L,B>
    
    public func fmap<B>(_ f : @escaping (R) -> B) -> Validation<L,B> {
        switch self {
        case .Failure(let a):
            return Validation<L,B>.Failure(a)
        case .Success(let b):
            return Validation<L,B>.Success(f(b))
        }
    }
}
