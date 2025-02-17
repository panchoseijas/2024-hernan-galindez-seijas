Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name',
		'maxCapacity',
		'currentFuel',
		'needsToThrow',
		'ally',
		'diceAdjustment',
		'cards',
		'fuelHistory'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Spaceship class >> withName: aName withFuel: fuelCapacity [

	^ self new initializeWithName: aName withFuel: fuelCapacity
]

{ #category : #accessing }
Spaceship >> allyWith: aSpaceship [

	ally := aSpaceship
]

{ #category : #setting }
Spaceship >> applyPenaltyIn: aGameboard [ 
	aGameboard spaceshipRanOutOfFuel: self.
	currentFuel := maxCapacity.
]

{ #category : #accessing }
Spaceship >> cards [

	^ cards
]

{ #category : #setting }
Spaceship >> changeCurrentFuelBy: anAmount [

	currentFuel := currentFuel - anAmount
]

{ #category : #accessing }
Spaceship >> changeFuelCapacityBy: anAmount [

	maxCapacity := maxCapacity + anAmount.
	currentFuel := maxCapacity min: currentFuel
]

{ #category : #setting }
Spaceship >> changeTotalThrowBy: aNumber [

	diceAdjustment := diceAdjustment + aNumber.
]

{ #category : #setting }
Spaceship >> discardRandomCard [

	cards removeAt: cards size atRandom
]

{ #category : #setting }
Spaceship >> giveCard: aCard [

	cards add: aCard deepCopy
]

{ #category : #initialization }
Spaceship >> initializeWithName: aName withFuel: fuelCapacity [

	name := aName.
	currentFuel := fuelCapacity.
	maxCapacity := fuelCapacity.
	needsToThrow := 0.
	diceAdjustment := 0.
	ally := NullSpaceship new.
	cards := OrderedCollection new.
	fuelHistory := OrderedCollection new.
]

{ #category : #accessing }
Spaceship >> move: anAmountOfSquares in: aGameboard [

	| squaresToMove |
	squaresToMove := anAmountOfSquares + diceAdjustment.

	self useAllyFuelIfNecessary: squaresToMove in: aGameboard.

	currentFuel > squaresToMove abs
		ifTrue: [
			self changeCurrentFuelBy:  squaresToMove abs.
			aGameboard move: self with: squaresToMove ]
		ifFalse: [ self applyPenaltyIn: aGameboard ]
]

{ #category : #accessing }
Spaceship >> name [

	^ name
]

{ #category : #initialization }
Spaceship >> needsToThrow: expectedNumber [

	needsToThrow := expectedNumber.
]

{ #category : #accessing }
Spaceship >> playWith: anAmountOfSquares in: aGameboard [

	self recordFuel.
	anAmountOfSquares abs < needsToThrow ifTrue: [ ^ self ].
	needsToThrow := 0.
	self move: anAmountOfSquares in: aGameboard
]

{ #category : #initialization }
Spaceship >> recordFuel [

	fuelHistory add: currentFuel.

	fuelHistory size < 3 ifTrue: [ ^ self ].

	fuelHistory removeFirst
]

{ #category : #setting }
Spaceship >> refuel [

	currentFuel := maxCapacity
]

{ #category : #initialization }
Spaceship >> restoreAllyFuel [

	ally restoreFuel.
]

{ #category : #setting }
Spaceship >> restoreFuel [

	fuelHistory size < 2 ifTrue: [
		Error signal:
			name, ' has not played two turns' ].
	currentFuel := fuelHistory first
]

{ #category : #accessing }
Spaceship >> takeFuel: anAmountOfFuel [

	anAmountOfFuel > currentFuel ifTrue: [ ^ 0 ].

	currentFuel := currentFuel - anAmountOfFuel.

	^ anAmountOfFuel
]

{ #category : #accessing }
Spaceship >> useAllyFuelIfNecessary: squaresToMove in: gameboard [

	| allyFuel |
	currentFuel <= squaresToMove abs ifFalse: [ ^ self ].

	allyFuel := ally takeFuel: squaresToMove - currentFuel + 1.

	currentFuel := currentFuel + allyFuel.

	currentFuel <= squaresToMove abs ifTrue: [
		ally applyPenaltyIn: gameboard ]
]

{ #category : #accessing }
Spaceship >> useCard: aCard [

	cards
		remove: aCard
		ifAbsent: [
		Error signal: self name , ' does not have a ' , aCard class name, ' card' ]
]
