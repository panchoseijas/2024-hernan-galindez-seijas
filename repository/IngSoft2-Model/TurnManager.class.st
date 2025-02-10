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
