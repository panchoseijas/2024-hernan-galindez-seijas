Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'players',
		'gameboard',
		'lastUsedCard',
		'turnManager',
		'activeCards',
		'nextPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardManager class >> players: playersCollection gameboard: aGameboard turnManager: aTurnManager [

	^ self new
		  initializeWithPlayers: playersCollection
		  withGameboard: aGameboard
		  withTurnManager: aTurnManager
]

{ #category : #accessing }
CardManager >> addActiveCard: aCard [

	activeCards add: aCard
]

{ #category : #effects }
CardManager >> applyAccelerationEffect [

	players do: [ :spaceship |
		spaceship changeTotalThrowBy: 1 ]
]

{ #category : #accessing }
CardManager >> applyLastEffectTo: aSpaceship [

	gameboard applyLastEffectTo: aSpaceship
]

{ #category : #effects }
CardManager >> applyOverloadEffectTo: affectedSpaceship [

	affectedSpaceship changeTotalThrowBy: -2
	
]

{ #category : #effects }
CardManager >> createAlliance: aSpaceship [

	nextPlayer allyWith: aSpaceship.
	aSpaceship allyWith: nextPlayer
]

{ #category : #effects }
CardManager >> createAllianceBetween: aSpaceship and: anotherSpaceshipName [

	| otherSpaceship |
	otherSpaceship := self shipNamed: anotherSpaceshipName.
	
	aSpaceship allyWith: otherSpaceship.
	otherSpaceship allyWith: aSpaceship.
]

{ #category : #initialization }
CardManager >> initializeWithPlayers: playersCollection withGameboard: aGameboard withTurnManager: aTurnManager [

	players := playersCollection.
	gameboard := aGameboard.
	activeCards := OrderedCollection new.
	turnManager := aTurnManager.
	lastUsedCard := NullCard new
]

{ #category : #effects }
CardManager >> invertSquare: anIndex [ 
	gameboard invertSquareOn: anIndex.
]

{ #category : #accessing }
CardManager >> playCard: aCard from: cardThrower target: aTarget [

	nextPlayer := turnManager nextPlayer.
	aCard verifyCanBePlayedBy: cardThrower with: turnManager.
	aCard use: self from: cardThrower target: aTarget.
	cardThrower useCard: aCard.
	lastUsedCard := aCard lastUsedCard: lastUsedCard
]

{ #category : #effects }
CardManager >> redoLastCardFrom: aSpaceship target: aTarget [

	nextPlayer := turnManager nextPlayer.
	lastUsedCard verifyCanBePlayedBy: aSpaceship with: turnManager.
	lastUsedCard use: self from: aSpaceship target: aTarget
]

{ #category : #removing }
CardManager >> removeAccelerationEffect [

	players do: [ :player | player changeTotalThrowBy: 1 negated ]
]

{ #category : #effects }
CardManager >> removeCardEffect: aCard [

	activeCards
		remove: aCard
		ifAbsent: [ Error signal: 'This card is not active' ].
	aCard removeEffectsWith: self
]

{ #category : #accessing }
CardManager >> shipNamed: aName [

	^ players detect: [ :ship | ship name = aName ] ifNone: [Error signal: 'No ship named ' , aName].
	

]

{ #category : #effects }
CardManager >> timeMachineEffectTo: aSpaceshipName [

	| spaceship |
	spaceship := self shipNamed: aSpaceshipName.
	
	spaceship restoreFuel.
	spaceship restoreAllyFuel.
]
