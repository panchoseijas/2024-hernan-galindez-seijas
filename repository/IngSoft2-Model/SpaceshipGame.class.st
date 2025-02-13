Class {
	#name : #SpaceshipGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'gameboard',
		'dice',
		'numberOfLaps',
		'rewards',
		'possibleCards',
		'redoCardInstance',
		'turnManager',
		'cardManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipGame class >> withPlayers: somePlayers withGameboardLength: aLength withDice: aDiceCollection withLaps: anAmountOfLaps withParsecs: aNumberOfParsecs [

	^ self new
		  initializeWithPlayers: somePlayers
		  withGameboardLength: aLength
		  withDice: aDiceCollection
		  withLaps: anAmountOfLaps
		  withParsecs: aNumberOfParsecs
]

{ #category : #'instance creation' }
SpaceshipGame class >> withPlayers: somePlayers withGameboardLength: aLength withDice: aDiceCollection withLaps: anAmountOfLaps withParsecs: aNumberOfParsecs squareGenerator: sqaureGenerator rewards: rewards cards: deckOfCards [


	^ self new
		  initializeWithPlayers: somePlayers
		  withGameboardLength: aLength
		  withDice: aDiceCollection
		  withLaps: anAmountOfLaps
		  withParsecs: aNumberOfParsecs
		  withSquareGenerator: sqaureGenerator
		  withRewards: rewards
		  withCards: deckOfCards

]

{ #category : #accessing }
SpaceshipGame >> deckOf: aSpaceshipName [

^ (self shipNamed: aSpaceshipName) cards.
]

{ #category : #initialization }
SpaceshipGame >> initializeWithPlayers: aCollectionOfPlayers withGameboardLength: aLength withDice: aDiceCollection withLaps: anAmountOfLaps withParsecs: aNumberOfParsecs [

	| squareGenerator cardCollection |
	dice := Dice with: aDiceCollection.

	squareGenerator := DefaultSquareGenerator distributions: {
			                   ([ NormalSquare create ] -> (3 / 10)).
			                   ([
			                    HyperGravity withExpectedNumber:
				                    dice maxThrow atRandom ] -> (2 / 10)).
			                   ([ AtomicBomb create ] -> (2 / 100)).
			                   ([ BlackHole create ] -> (2 / 10)).
			                   ([
			                    MoonWalk withSquaresToMove:
				                    dice maxThrow atRandom ] -> (1 / 10)).
			                   ([ HyperJump with: { (Parsecs of: 100) } ]
			                    -> (8 / 100)).
			                   ([ CardSquare create ] -> (1 / 10)) }.

	rewards := RewardsManager with: {
			           ((DecrementCurrentFuel by: 1) -> 0.2).
			           ((IncrementFuelCapacity by: 1) -> 0.8) }.

	possibleCards := {
		                 Cancellation new.
		                 Repeat new.
		                 Acceleration new.
		                 Ally new.
		                 Overload new.
		                 Redo new }.

	redoCardInstance := Redo recreate.

	players := aCollectionOfPlayers collect: [ :playerName |
		           Spaceship
			           withName: playerName
			           withFuel: dice maxThrow * 2 ].

	players do: [ :player |
		player
			giveCard: possibleCards atRandom;
			giveCard: possibleCards atRandom ].

	Redo deleteInstance.

	turnManager := TurnManager initializeWithPlayers: players.
	gameboard := Gameboard
		             numberOfSquares: aLength
		             spaceships: players
		             turnManager: turnManager
		             withParsecs: aNumberOfParsecs
		             using: dice
		             generator: squareGenerator
		             cards: possibleCards.

	numberOfLaps := anAmountOfLaps
]

{ #category : #initialization }
SpaceshipGame >> initializeWithPlayers: aCollectionOfPlayers withGameboardLength: aLength withDice: aDiceCollection withLaps: anAmountOfLaps withParsecs: aNumberOfParsecs withSquareGenerator: squareGenerator withRewards: aReward withCards: cardCollection [

	dice := Dice with: aDiceCollection.


	players := aCollectionOfPlayers collect: [ :playerName |
		           Spaceship
			           withName: playerName
			           withFuel: dice maxThrow * 2 ].
	redoCardInstance := Redo recreate.
	possibleCards := cardCollection deepCopy.

	turnManager := TurnManager initializeWithPlayers: players.

	players do: [ :player |
		player
			giveCard: possibleCards first deepCopy;
			giveCard: possibleCards second deepCopy ].

	Redo deleteInstance.
	gameboard := Gameboard
		             numberOfSquares: aLength
		             spaceships: players
		             turnManager: turnManager
		             withParsecs: aNumberOfParsecs
		             using: dice
		             generator: squareGenerator
		             cards:
		             (possibleCards copyFrom: 3 to: possibleCards size).
	numberOfLaps := anAmountOfLaps.

	cardManager := CardManager
		               players: players
		               gameboard: gameboard
		               turnManager: turnManager.
	rewards := aReward
]

{ #category : #'game logic' }
SpaceshipGame >> isOver [

	^ players anySatisfy: [ :aSpaceship |
		  (gameboard lapsCompletedOf: aSpaceship) >= numberOfLaps ]
]

{ #category : #accessing }
SpaceshipGame >> lapsCompletedOf: aSpaceshipName [

	| aSpaceship |
	aSpaceship := players detect: [ :player |
		              player name = aSpaceshipName ].


	^ gameboard lapsCompletedOf: aSpaceship
]

{ #category : #'game controls' }
SpaceshipGame >> playCard: card from: spaceshipName target: target [

	| spaceshipToPlay spaceship cardToBeUsed |
	self verifyGameIsNotOver.
	spaceship := self shipNamed: spaceshipName.
	cardManager playCard: card from: spaceship target: target
	
	"	spaceshipToPlay := turnManager nextPlayer.
	spaceship := players detect: [ :player | player name = spaceshipName ].

	cardToBeUsed := spaceship useCard: card.
	""	cardToBeUsed lastUsedCard: lastUsedCard.""
	cardToBeUsed verifyCanBePlayed: spaceshipToPlay = spaceship.

	cardToBeUsed applyFrom: spaceship target: target in: gameboard.

	""card canBeReDone ifFalse: [ ^ self ].""
	""lastUsedCard := cardToBeUsed""
	redoCardInstance lastUsedCard: cardToBeUsed"
]

{ #category : #'game controls' }
SpaceshipGame >> playTurn [

	| aNumber spaceshipToPlay |
	self verifyGameIsNotOver.
	spaceshipToPlay := turnManager spaceshipToPlay.
	aNumber := dice throw.
	aNumber = dice maxThrow ifTrue: [ rewards applyTo: spaceshipToPlay ].
	spaceshipToPlay playWith: aNumber in: gameboard.
	gameboard applyEffectTo: spaceshipToPlay
]

{ #category : #'game logic' }
SpaceshipGame >> positionOf: aSpaceshipName [

	| aSpaceship |
	aSpaceship := players detect: [ :player |
		              player name = aSpaceshipName ].
	^ gameboard find: aSpaceship
]

{ #category : #'game logic' }
SpaceshipGame >> rankings [

	| comparisonBlock sortedCollection playerPosition playerLap playerPositionArray |
	self isOver ifFalse: [ Error signal: 'Game is not over' ].

	comparisonBlock := [ :a :b | a second >= b second ].

	sortedCollection := SortedCollection sortBlock: comparisonBlock.

	players do: [ :player |
		playerPosition := gameboard find: player.
		playerLap := gameboard lapsCompletedOf: player.
		playerPositionArray := OrderedCollection
			                       with: player
			                       with:
			                       (Position
				                        laps: playerLap
				                        cell: playerPosition).
		sortedCollection add: playerPositionArray ].


	^ sortedCollection collect: [ :position | position first name ]
]

{ #category : #accessing }
SpaceshipGame >> shipNamed: aName [

	^ players
		  detect: [ :player | player name = aName ]
		  ifNone: [ Error signal: 'There are no spaceship named' , aName ]
]

{ #category : #'game logic' }
SpaceshipGame >> skipTurn [

	| currentPlayer |
	currentPlayer := turnManager spaceshipToPlay.
	currentPlayer refuel
]

{ #category : #'game logic' }
SpaceshipGame >> verifyGameIsNotOver [

	self isOver ifTrue: [ Error signal: 'Game is over' ]
]

{ #category : #'game logic' }
SpaceshipGame >> winner [

	| raceWinner |
	raceWinner := players
		              detect: [ :player |
		              (gameboard lapsCompletedOf: player) >= numberOfLaps ]
		              ifNone: [ Error signal: 'There is no winner yet' ].
	^ raceWinner name
]
