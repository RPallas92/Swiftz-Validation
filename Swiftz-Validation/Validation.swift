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

extension Validation /*: Functor*/ {
    public typealias A = R
    public typealias B = Any
    public typealias FB = Validation<L,B>
    
    public func fmap<B>(_ f : @escaping (A) -> B) -> Validation<L,B> {
        switch self {
        case .Failure(let a):
            return Validation<L,B>.Failure(a)
        case .Success(let b):
            return Validation<L,B>.Success(f(b))
        }
    }
}

extension Validation /*: Pointed*/ {
    public static func pure(_ x : R) -> Validation<L,R> {
        return Validation.Success(x)
    }
}


extension Validation /*: Applicative*/ {
    public typealias FAB = Validation<L, (A) -> B>
    
    public func ap<B>(_ f : Validation<L,(A) -> B>) -> Validation<L,B> {
        switch self {
        case .Success(let b):
            return f.fmap{ $0(b) }
        case .Failure(let l):
            return Validation<L,B>.Failure(l)

        }
    }
}

extension Validation /*: ApplicativeOps*/ {
    public typealias C = Any
    public typealias FC = Validation<L,C>

    
    public static func liftA<B>(_ f : @escaping (A) -> B) -> (Validation<L,A>) -> Validation<L,B> {
        return { (a : Validation<L,A>) -> Validation<L,B> in
            return a.ap(Validation<L, (A) -> B>.pure(f))
        }
    }

    public static func liftA2<B>(_ f : @escaping (A) -> (B) -> C) -> (Validation<L,A>) -> (Validation<L,B>) -> Validation<L,C> {
        return { (a : Validation<L,A>) -> (Validation<L,B>) -> Validation<L,C> in
            { (b:Validation<L,B>) -> Validation<L,C> in
                return b.ap(a.fmap(f))
            }
        }
    }
}

extension Validation where L:Concatable/*: Semigroup*/ {
    
    typealias FA = Validation<L,A>
    
    func sconcat(other : FA) -> FA {
        switch self {
        case .Success( _):
            return other
        case .Failure(let error):
            switch other {
            case .Success( _):
                return self
            case .Failure(let otherError):
                return Validation<L,A>.Failure(error.concat(otherError))

            }
        }
    }
}


