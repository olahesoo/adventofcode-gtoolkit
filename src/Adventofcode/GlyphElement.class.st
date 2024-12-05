Class {
	#name : #GlyphElement,
	#superclass : #BlElement,
	#instVars : [
		'character'
	],
	#category : #'Adventofcode-Utils'
}

{ #category : #'instance creation' }
GlyphElement class >> fromCharacter: aCharacter [
	^ self new useCharacter: aCharacter
]

{ #category : #initialization }
GlyphElement >> initialize [
	super initialize.
	self size: 20 asPoint.
	self layout: BlFrameLayout new
]

{ #category : #'as yet unclassified' }
GlyphElement >> useCharacter: aCharacter [
	character := BlTextElement new text: aCharacter asRopedText.
	character constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter].
	self addChild: character
]
