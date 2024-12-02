Class {
	#name : #EngineElement,
	#superclass : #BlScrollableElement,
	#instVars : [
		'engine',
		'componentElements'
	],
	#category : #'Adventofcode-2023-03'
}

{ #category : #initialization }
EngineElement class >> initializeFor: anEngine [
	| engineElement |
	engineElement := self new.
	engineElement engine: anEngine.
	engineElement size: (anEngine width * 20) @ (anEngine height * 20).
	engineElement componentElements: (anEngine components collect: [ :c |
		| componentElement |
		componentElement := EngineComponentElement initializeFor: c.
		componentElement relocate: (c column - 1 * 20) @ (c row - 1 * 20).
		(anEngine isPartComponent: c) ifTrue: [ componentElement background: Color lightCyan ].
		(anEngine isGear: c) ifTrue: [ componentElement background: Color lightRed ].
		((c content = #*) & ((anEngine isGear: c) not)) ifTrue: [ componentElement background: Color yellow].
		(c content = 443) ifTrue: [ componentElement background: Color green ].
		componentElement
	]).
	engineElement addChildren: engineElement componentElements.
	^ engineElement
]

{ #category : #accessing }
EngineElement >> componentElements [
	^ componentElements
]

{ #category : #accessing }
EngineElement >> componentElements: anObject [
	componentElements := anObject
]

{ #category : #accessing }
EngineElement >> engine [
	^ engine
]

{ #category : #accessing }
EngineElement >> engine: anObject [
	engine := anObject
]
