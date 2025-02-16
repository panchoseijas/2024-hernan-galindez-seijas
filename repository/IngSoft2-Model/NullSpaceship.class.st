Class {
	#name : #NullSpaceship,
	#superclass : #Spaceship,
	#category : #'IngSoft2-Model'
}

{ #category : #setting }
NullSpaceship >> applyPenaltyIn: gameboard [

	^ self
]

{ #category : #setting }
NullSpaceship >> restoreFuel [

	^ self
]

{ #category : #accessing }
NullSpaceship >> takeFuel: anAmountOfFuel [

	^ 0
]
