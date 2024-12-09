Class {
	#name : #AntennaParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'empty',
		'antenna',
		'line'
	],
	#category : #'Adventofcode-2024-08'
}

{ #category : #grammar }
AntennaParser >> antenna [
	^ (#letter asPParser / #digit asPParser) token trim: empty
]

{ #category : #grammar }
AntennaParser >> empty [
	^ $. asPParser star
]

{ #category : #grammar }
AntennaParser >> line [
	^ antenna star
]

{ #category : #accessing }
AntennaParser >> start [
	^ line
]
