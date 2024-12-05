Class {
	#name : #Engine,
	#superclass : #Object,
	#instVars : [
		'components',
		'width',
		'height',
		'coordinatesMap'
	],
	#category : #'Adventofcode-2023-03'
}

{ #category : #'instance creation' }
Engine class >> fromLines: lines [
	| components engine |
	
	components := (lines withIndexCollect: [ :line :index | self parseRow: line withIndex: index ]) flatten.
	engine := self new.
	engine addComponents: components.
	engine height: lines size.
	engine width: lines first size.
	^ engine
]

{ #category : #transformation }
Engine class >> parseOneLine [
	<gtExample>
	
	| components |
	components := self parseRow: '.*.25.4@..$..' withIndex: 1.
	self assert: components size equals: 5.
	self assert: components first row equals: 1.
	self assert: components first column equals: 2.
	self assert: components first content equals: '*'.
	^ components
]

{ #category : #transformation }
Engine class >> parseRow: aLine withIndex: aNumber [
	| tokens components |
	tokens := EngineParser new parse: aLine.
	components := tokens collect: [ :t | EngineComponent fromToken: t atIndex: aNumber ].
	^ components
]

{ #category : #'as yet unclassified' }
Engine >> addComponent: aComponent [
	components add: aComponent.
	aComponent getCoordinates do: [ :c | coordinatesMap at: c put: aComponent ]
]

{ #category : #'as yet unclassified' }
Engine >> addComponents: someComponents [
	someComponents do: [ :c | self addComponent: c ]
]

{ #category : #accessing }
Engine >> adjacentComponents: aComponent [
	^ ((aComponent getAdjacentCoordinates collectAsSet: [ :c | coordinatesMap at: c ifAbsent: nil ]) reject: [ :c | c isNil ]) asBag
]

{ #category : #accessing }
Engine >> adjacentToComponent: aComponent [
	^ (aComponent getAdjacentCoordinates collectAsSet: [ :c | coordinatesMap at: c ifAbsent: nil ]) select: [ :c | c ]
]

{ #category : #'as yet unclassified' }
Engine >> adjacentToSymbol: aComponent [
	^ (self adjacentComponents: aComponent) detect: [ :c | c isSymbolComponent ] ifFound: [ ^ true ] ifNone: [ ^ false ]
]

{ #category : #accessing }
Engine >> components [
	^ components
]

{ #category : #example }
Engine >> createEngine [
	<gtExample>
	
	| inputLines engine |
	inputLines := Character cr split: '...25...
..$..*..
....456.
12......'.
	engine := self class fromLines: inputLines.
	self assert: engine components size equals: 5.
	^ engine
	
]

{ #category : #'as yet unclassified' }
Engine >> gearRatio: aComponent [
	^ (self isGear: aComponent) ifTrue: [
		| componentValues |
		componentValues := (self adjacentComponents: aComponent) select: [ :c | c isNumberComponent ] thenCollect: [ :c | c content ].
		componentValues inject: 1 into: [ :acc :n | acc * n ]
	] ifFalse: [ self error: (aComponent asString , ' is not a gear in this engine') ]
]

{ #category : #'as yet unclassified' }
Engine >> gearRatios [
	^ self gears collect: [ :g | self gearRatio: g ]
]

{ #category : #'as yet unclassified' }
Engine >> gearRatiosSum [
	^ self gearRatios sum
]

{ #category : #'as yet unclassified' }
Engine >> gears [
	^ self components select: [ :c | self isGear: c ]
]

{ #category : #'as yet unclassified' }
Engine >> gtEngineViewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Engine';
		priority: 150;
		stencil: [ (EngineElement initializeFor: self) gtPreviewElement ]
]

{ #category : #'as yet unclassified' }
Engine >> gtGridView [
]

{ #category : #accessing }
Engine >> height [
	^ height
]

{ #category : #accessing }
Engine >> height: anObject [
	height := anObject
]

{ #category : #'as yet unclassified' }
Engine >> initialize [
	components := OrderedCollection new.
	coordinatesMap := Dictionary new.
]

{ #category : #'as yet unclassified' }
Engine >> isGear: aComponent [
	^ (aComponent content = #*) & (((self adjacentComponents: aComponent) select: [ :c | c isNumberComponent ]) size = 2)
]

{ #category : #'as yet unclassified' }
Engine >> isPartComponent: aComponent [
	^ (aComponent isNumberComponent) & (self adjacentToSymbol: aComponent)
]

{ #category : #'as yet unclassified' }
Engine >> partComponents [
	^ self components select: [ :c | self isPartComponent: c ]
]

{ #category : #'as yet unclassified' }
Engine >> partsSum [
	^ self partComponents sumNumbers: [ :c | c content ]
]

{ #category : #accessing }
Engine >> width [
	^ width
]

{ #category : #accessing }
Engine >> width: anObject [
	width := anObject
]
