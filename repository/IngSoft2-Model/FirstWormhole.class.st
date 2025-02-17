Class {
	#name : #FirstWormhole,
	#superclass : #Wormhole,
	#category : #'IngSoft2-Model'
}

{ #category : #'add/remove' }
FirstWormhole >> applyInvertedEffectTo: aSpaceship in: aGameboard [

	occupiedBy remove: aSpaceship.
	connection keep: aSpaceship.
	aGameboard substractLapTo: aSpaceship
]
