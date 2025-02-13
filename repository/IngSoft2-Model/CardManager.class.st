Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'players',
		'gameboard',
		'possibleCards',
		'lastUsedCard',
		'turnManager',
		'deck',
		'activeCards',
		'cardThrower'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardManager class >> players: playersCollection gameboard: aGameboard deck: aDeck turnManager: aTurnManager [

	^ self new
		  initializeWithPlayers: playersCollection
		  withGameboard: aGameboard
		  withDeck: aDeck
		  withTurnManager: aTurnManager
]

{ #category : #initialization }
CardManager >> addActiveCard: aCard [

	activeCards add: aCard
]

{ #category : #initialization }
CardManager >> applyAccelerationEffect [

	players do: [ :spaceship |
		spaceship applyCard: self.
		spaceship changeTotalThrowBy: 1 ]
]

{ #category : #initialization }
CardManager >> applyLastCardEffect [
	
	lastUsedCard use: self 
]

{ #category : #accessing }
CardManager >> applyLastEffectTo: aSpaceship [

	gameboard applyLastEffectTo: aSpaceship
]

{ #category : #initialization }
CardManager >> applyOverloadEffectTo: affectedSpaceship [

	affectedSpaceship changeTotalThrowBy: -2
	
]

{ #category : #initialization }
CardManager >> createAlliance: aSpaceship [

	cardThrower allyWith: aSpaceship.
	aSpaceship allyWith: cardThrower
]

{ #category : #initialization }
CardManager >> createAllianceBetween: aSpaceship and: anotherSpaceshipName [

	| otherSpaceship |
	otherSpaceship := self shipNamed: anotherSpaceshipName.
	
	aSpaceship allyWith: otherSpaceship.
	otherSpaceship allyWith: aSpaceship.
]

{ #category : #initialization }
CardManager >> initializeWithPlayers: playersCollection withGameboard: aGameboard withDeck: aDeck withTurnManager: aTurnManager [

	players := playersCollection.
	gameboard := aGameboard.
	deck := aDeck.
	activeCards := OrderedCollection new.
	turnManager := aTurnManager.
	lastUsedCard := NullCard new
]

{ #category : #initialization }
CardManager >> playCard: aCard from: aSpaceship target: aTarget [

	cardThrower := turnManager nextPlayer.
	aCard verifyCanBePlayed: cardThrower = aSpaceship.
	aSpaceship useCard: aCard.
	aCard use: self from: cardThrower target: aTarget.
	lastUsedCard := aCard lastUsedCard: lastUsedCard.
]

{ #category : #initialization }
CardManager >> redoLastCardFrom: aSpaceship target: aTarget [

	cardThrower := turnManager nextPlayer.
	lastUsedCard verifyCanBePlayed: cardThrower = aSpaceship.
	lastUsedCard use: self from: aSpaceship target: aTarget
]

{ #category : #removing }
CardManager >> removeAccelerationEffect [

	players do: [ :player | player changeTotalThrowBy: 1 negated ]
]

{ #category : #initialization }
CardManager >> removeCardEffect: aCard [

	activeCards
		remove: aCard
		ifAbsent: [ Error signal: 'This card is not active' ].
	aCard removeEffectsWith: self
]

{ #category : #initialization }
CardManager >> shipNamed: aName [

	^ players detect: [ :ship | ship name = aName ] ifNone: [Error signal: 'No ship named ' , aName].
	

]
