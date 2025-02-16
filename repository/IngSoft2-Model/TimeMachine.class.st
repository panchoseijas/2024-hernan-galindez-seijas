Class {
	#name : #TimeMachine,
	#superclass : #Instant,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
TimeMachine >> use: aCardManager from: cardThrower target: aTarget [

	aCardManager timeMachineEffectTo: aTarget
]
