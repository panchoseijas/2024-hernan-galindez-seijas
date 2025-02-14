Class {
	#name : #SecondWormhole,
	#superclass : #Wormhole,
	#category : #'IngSoft2-Model'
}

{ #category : #'add/remove' }
SecondWormhole >> applyInvertedEffectTo: aSpaceship in: aGameboard [

	occupiedBy remove: aSpaceship.
	connection keep: aSpaceship.
	aGameboard addLapTo: aSpaceship
]
