Class {
	#name : #Overload,
	#superclass : #Permanent,
	#instVars : [
		'affectedSpaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #removing }
Overload >> initialize [

	affectedSpaceship := NullSpaceship new
]

{ #category : #removing }
Overload >> removeEffectsWith: aCardManager [
	"affectedSpaceship removeEffect: self"

	affectedSpaceship changeTotalThrowBy: 2
]

{ #category : #operations }
Overload >> use: aCardManager from: cardThrower target: aTarget [

	affectedSpaceship := aCardManager shipNamed: aTarget.
	aCardManager applyOverloadEffectTo: affectedSpaceship.

	aCardManager addActiveCard: self
]
