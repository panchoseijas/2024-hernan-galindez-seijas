Class {
	#name : #AtomicBomb,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #'add/remove' }
AtomicBomb >> applyInvertedEffectTo: aSpaceship in: aGameboard [

	self applyNormalEffectTo: aSpaceship in: aGameboard
]

{ #category : #'add/remove' }
AtomicBomb >> applyNormalEffectTo: aSpaceship in: aGameboard [

	aGameboard moveAllToStart 
]
