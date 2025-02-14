Class {
	#name : #BlackHole,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #'add/remove' }
BlackHole >> applyInvertedEffectTo: aSpaceship in: aGameboard [

	aSpaceship move: 4 in: aGameboard
]

{ #category : #'add/remove' }
BlackHole >> applyNormalEffectTo: aSpaceship in: aGameboard [

	aSpaceship move: 4 negated in: aGameboard
]
