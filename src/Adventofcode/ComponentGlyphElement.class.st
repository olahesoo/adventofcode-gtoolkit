Class {
	#name : #ComponentGlyphElement,
	#superclass : #BlElement,
	#instVars : [
		'character'
	],
	#category : #'Adventofcode-2023-03'
}

{ #category : #'instance creation' }
ComponentGlyphElement class >> fromCharacter: aCharacter [
	^ self new initializeCharacter: aCharacter
]

{ #category : #initialization }
ComponentGlyphElement >> initialize [
	super initialize.
	self size: 20 asPoint.
	self layout: BlFrameLayout new
]

{ #category : #'as yet unclassified' }
ComponentGlyphElement >> initializeCharacter: aCharacter [
	character := BlTextElement new text: aCharacter asRopedText.
	character constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter].
	self addChild: character
]
