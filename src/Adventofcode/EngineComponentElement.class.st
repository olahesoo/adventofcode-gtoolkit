Class {
	#name : #EngineComponentElement,
	#superclass : #BlElement,
	#instVars : [
		'component'
	],
	#category : #'Adventofcode-2023-03'
}

{ #category : #'as yet unclassified' }
EngineComponentElement class >> initializeFor: aComponent [
	| element contentArray glyphs |
	element := self new.
	element component: aComponent.
	contentArray := aComponent content asString asArray.
	element size: (contentArray size * 20 @ 20).
	glyphs := contentArray collect: [ :c |
		GlyphElement fromCharacter: c ].
	element addChildren: glyphs.
	^ element
]

{ #category : #accessing }
EngineComponentElement >> component [
	^ component
]

{ #category : #accessing }
EngineComponentElement >> component: anObject [
	component := anObject
]

{ #category : #'as yet unclassified' }
EngineComponentElement >> initialize [
	super initialize.
	self layout: BlFlowLayout horizontal alignCenter;
	border: (BlBorder builder paint: Color black; build).
]
