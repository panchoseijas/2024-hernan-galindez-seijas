Class {
	#name : #Cancellation,
	#superclass : #Instant,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Cancellation >> use: aCardManager from: cardThrower target: aTarget [

	aCardManager removeCardEffect: aTarget
]
