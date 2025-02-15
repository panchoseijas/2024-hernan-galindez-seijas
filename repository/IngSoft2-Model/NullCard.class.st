Class {
	#name : #NullCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
NullCard >> verifyCanBePlayedBy: aSpaceship with: aTurnManager [

	Error signal: 'There is no card to redo'
]
