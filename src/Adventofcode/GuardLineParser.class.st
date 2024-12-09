Class {
	#name : #GuardLineParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'empty',
		'obstacle',
		'guard',
		'line'
	],
	#category : #'Adventofcode-2024-06'
}

{ #category : #grammar }
GuardLineParser >> empty [
	^ $. asPParser star
]

{ #category : #grammar }
GuardLineParser >> guard [
	^ $^ asPParser token
]

{ #category : #grammar }
GuardLineParser >> line [
	^ (obstacle | guard trim: empty) star
]

{ #category : #grammar }
GuardLineParser >> obstacle [
	^ $# asPParser token
]

{ #category : #accessing }
GuardLineParser >> start [
	^ line
]
