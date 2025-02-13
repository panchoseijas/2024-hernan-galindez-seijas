Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Card >> initialize [
]

{ #category : #operations }
Card >> lastUsedCard: aCard [

	^ self
]

{ #category : #operations }
Card >> use: aCardManager from: cardThrower target: aTarget [

	self subclassResponsibility
]

{ #category : #operations }
Card >> verifyCanBePlayed: isShipTurn [

	self subclassResponsibility
]
