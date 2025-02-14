Class {
	#name : #Wormhole,
	#superclass : #Square,
	#instVars : [
		'connection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Wormhole class >> newPair [

	| aWormhole anotherWormhole wormholePair |
	aWormhole := FirstWormhole new.
	anotherWormhole := SecondWormhole new.
	aWormhole connectTo: anotherWormhole.
	anotherWormhole connectTo: aWormhole.

	wormholePair := OrderedCollection
		                with: aWormhole
		                with: anotherWormhole.
	^ wormholePair
]

{ #category : #'instance creation' }
Wormhole class >> newPairIn: aBoard at: firstPosition and: secondPosition [

	| aWormhole anotherWormhole wormholePair |
	aWormhole := FirstWormhole new.
	anotherWormhole := SecondWormhole new.
	aWormhole connectTo: anotherWormhole.
	anotherWormhole connectTo: aWormhole.

	wormholePair := OrderedCollection
		                with: aWormhole
		                with: anotherWormhole.
	aBoard at: firstPosition put: aWormhole.
	aBoard at: secondPosition put: anotherWormhole
]

{ #category : #'add/remove' }
Wormhole >> applyInvertedEffectTo: aSpaceship in: aGameboard [

	self subclassResponsibility
]

{ #category : #'add/remove' }
Wormhole >> applyNormalEffectTo: aSpaceship in: aGameboard [

	occupiedBy remove: aSpaceship.
	connection keep: aSpaceship
]

{ #category : #'public - line' }
Wormhole >> connectTo: anotherWormhole [

	connection := anotherWormhole
]

{ #category : #'add/remove' }
Wormhole >> invert [

	state := state invert.
	connection onlyInvertSelf
]

{ #category : #'add/remove' }
Wormhole >> onlyInvertSelf [

	state := state invert
]
