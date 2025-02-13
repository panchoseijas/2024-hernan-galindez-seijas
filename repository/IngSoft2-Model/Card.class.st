Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
Card >> = anotherCard [

	^(anotherCard = self)
]

{ #category : #operations }
Card >> applyFrom: aSpaceship target: otherSpaceships in: lastSquareLandedOn [

	self subclassResponsibility.
]

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
