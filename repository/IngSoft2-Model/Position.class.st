Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'laps',
		'cell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Position class >> laps: lapsAmount cell: currentCell [

^ (self new ) initializeWithLaps: lapsAmount withCell: currentCell
]

{ #category : #comparing }
Position >> >= aPosition [
    ^ ( laps > aPosition laps) 
        or: [( laps = aPosition laps) and: [ cell >= aPosition cell]].

]

{ #category : #comparing }
Position >> cell [

	^ cell
]

{ #category : #initialization }
Position >> initializeWithLaps: lapsAmount withCell: currentCell [

	laps := lapsAmount.
	cell := currentCell
]

{ #category : #comparing }
Position >> laps [

	^ laps
]
