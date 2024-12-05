Class {
	#name : #XmasSearchElement,
	#superclass : #BlElement,
	#instVars : [
		'xmasSearch',
		'letterElements',
		'scaleFactor'
	],
	#category : #'Adventofcode-2024-04'
}

{ #category : #'instance creation' }
XmasSearchElement class >> forXmasSearch: search [
	^ self new useXmasSearch: search
]

{ #category : #initialization }
XmasSearchElement >> initialize [
	super initialize.
	letterElements := Dictionary new.
	scaleFactor := 20@20
]

{ #category : #marking }
XmasSearchElement >> markFrom: startPoint direction: directionPoint length: aLength color: aColor [
	0 to: aLength - 1 do: [ :index |
		(letterElements at: index * directionPoint + startPoint) background: aColor
	]
]

{ #category : #'as yet unclassified' }
XmasSearchElement >> markX_mas [
	xmasSearch findX_mas do: [ :centerPoint |
		| topLeft |
		topLeft := -1@(-1) + centerPoint.
		{
		centerPoint.
		topLeft.
		topLeft rotateBy: #left centerAt: centerPoint.
		topLeft rotateBy: #right centerAt: centerPoint.
		topLeft rotateBy: #pi centerAt: centerPoint
		} do: [ :point | (letterElements at: point) background: Color lightCyan ].
	]
]

{ #category : #marking }
XmasSearchElement >> markXmas [
	xmasSearch findXmas do: [ :xmas |
		| startPoint direction |
		startPoint := xmas first.
		direction := xmas second.
		self markFrom: startPoint direction: direction length: 4 color: Color lightRed
	]
]

{ #category : #initialization }
XmasSearchElement >> useXmasSearch: search [
	xmasSearch := search.
	self size: (((xmasSearch sideLength + 1) @ (xmasSearch sideLength + 1)) scaleBy: scaleFactor).
	xmasSearch letters keysAndValuesDo: [ :position :letter |
		| letterElement |
		letterElement := GlyphElement fromCharacter: letter.
		letterElement relocate: (position scaleBy: scaleFactor).
		letterElements at: position put: letterElement.
		self addChild: letterElement
	]
]
