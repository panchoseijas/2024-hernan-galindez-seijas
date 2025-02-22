Class {
	#name : #TurnManager,
	#superclass : #Object,
	#instVars : [
		'playersPenalization',
		'turnOrder'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
TurnManager class >> initializeWithPlayers: aPlayerCollection [

	^ self new initializeWithPlayers: aPlayerCollection
]

{ #category : #'game logic' }
TurnManager >> applyPenalty: aNumber to: aSpoaceship [

	playersPenalization at: aSpoaceship update: [ :x | x + aNumber ]
]

{ #category : #'game logic' }
TurnManager >> initializeWithPlayers: playersCollection [

	turnOrder := playersCollection copy.

	playersPenalization := Dictionary new.


	playersCollection do: [ :player |
		playersPenalization at: player put: 0 ]
]

{ #category : #'game logic' }
TurnManager >> nextPlayer [

	^ turnOrder detect: [ :player | (playersPenalization  at: player) = 0 ]
]

{ #category : #'game logic' }
TurnManager >> spaceshipToPlay [

	| currentPlayer |
	currentPlayer := turnOrder removeFirst.
	turnOrder addLast: currentPlayer.



	[ (playersPenalization at: currentPlayer) = 0 ] whileFalse: [
		playersPenalization at: currentPlayer update: [ :x | x - 1 ].
		currentPlayer := turnOrder removeFirst.
		turnOrder addLast: currentPlayer ].


	^ currentPlayer
]
