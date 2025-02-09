Class {
	#name : #Repeat,
	#superclass : #Instant,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Repeat >> applyFrom: aSpaceship target: otherSpaceships in: gameboard [

	| target |
	target := players detect: [ :player | player name = otherSpaceships ].
	gameboard applyLastEffectTo: target
]
