Class {
	#name : #Engine,
	#superclass : #Object,
	#instVars : [
		'components',
		'width',
		'height'
	],
	#category : #'Adventofcode-2023-03'
}

{ #category : #'instance creation' }
Engine class >> fromLines: lines [
	| components engine |
	
	components := (lines withIndexCollect: [ :line :index | self parseRow: line withIndex: index ]) flatten.
	engine := self new.
	engine components: components.
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
	self assert: components first equals: (EngineComponent fromCoordinates: {2@1} asSet withContent: #*).
	^ components
]

{ #category : #transformation }
Engine class >> parseRow: aLine withIndex: aNumber [
	| tokens components |
	tokens := EngineParser new parse: aLine.
	components := tokens collect: [ :t | EngineComponent fromToken: t atIndex: aNumber ].
	^ components
]

{ #category : #accessing }
Engine >> components [
	^ components
]

{ #category : #accessing }
Engine >> components: anObject [
	components := anObject
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

{ #category : #accessing }
Engine >> width [
	^ width
]

{ #category : #accessing }
Engine >> width: anObject [
	width := anObject
]
