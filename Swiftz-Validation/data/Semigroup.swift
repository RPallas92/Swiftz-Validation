//
//  Semigroup.swift
//  Swiftz
//
//  Created by Maxwell Swadling on 3/06/2014.
//  Copyright (c) 2014-2016 Maxwell Swadling. All rights reserved.
//


/// A Semigroup is a type with a closed, associative, binary operator.
public protocol Semigroup {

	/// An associative binary operator.
	func op(_ other : Self) -> Self
}

public func sconcat <A : Semigroup>(lhs : A, rhs : A) -> A {
	return lhs.op(rhs)
}

public func sconcat<S: Semigroup>(_ h : S, _ t : [S]) -> S {
	return t.reduce(h) { $0.op($1) }
}
