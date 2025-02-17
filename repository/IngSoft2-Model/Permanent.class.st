Class {
	#name : #Permanent,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #removing }
Permanent >> removeEffectsWith: aCardManager [
	self subclassResponsibility 
]

{ #category : #operations }
Permanent >> verifyCanBePlayedBy: aSpaceship with: aTurnManager [

	aSpaceship = aTurnManager nextPlayer ifFalse: [
		Error signal: 'You can only play this card when its your turn' ]
]
