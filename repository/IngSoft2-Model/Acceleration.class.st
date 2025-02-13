Class {
	#name : #Acceleration,
	#superclass : #Permanent,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Acceleration >> removeEffectsWith: aCardManager [

	aCardManager removeAccelerationEffect.
]

{ #category : #operations }
Acceleration >> use: aCardManager from: cardThrower target: aTarget [

	aCardManager applyAccelerationEffect.
	aCardManager addActiveCard: self
]
