Class {
	#name : #Redo,
	#superclass : #Card,
	#instVars : [
		'lastUsedCard'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Redo >> lastUsedCard: aCard [

	^ aCard
]

{ #category : #operations }
Redo >> use: aCardManager from: cardThrower target: aTarget [

	aCardManager redoLastCardFrom: cardThrower target: aTarget
]

{ #category : #operations }
Redo >> verifyCanBePlayedBy: aSpaceship with: aTurnManager [

	^ self
]
