Class {
	#name : #EngineComponent,
	#superclass : #Object,
	#instVars : [
		'coordinatesSet',
		'content'
	],
	#category : #'Adventofcode-2023-03'
}

{ #category : #transformation }
EngineComponent class >> coordinatesFromInterval: anInterval atIndex: aNumber [
	^ anInterval collectAsSet: [ :column | aNumber @ column ]
]

{ #category : #example }
EngineComponent class >> createFromTokens [
	<gtExample>
	
	| token component |
	token := EngineParser parseExample first.
	component := self fromToken: token atIndex: 3.
	self assert: component coordinatesSet equals: {3@3 . 4@3} asSet.
	self assert: component content equals: 25.
	^ component
]

{ #category : #'instance creation' }
EngineComponent class >> fromCoordinates: aSet withContent: anObject [
	| component |
	component := self new .
	component coordinatesSet: aSet.
	component content: anObject.
	^ component
]

{ #category : #'instance creation' }
EngineComponent class >> fromToken: aToken atIndex: aNumber [
	| coordinates component |
	coordinates := (aToken at: #location) collectAsSet: [ :i | i @ aNumber ].
	component := self fromCoordinates: coordinates withContent: (aToken at: #value).
	^ component
]

{ #category : #equality }
EngineComponent >> = aComponent [
	^ (self coordinatesSet = aComponent coordinatesSet) & (self content = aComponent content)
]

{ #category : #accessing }
EngineComponent >> content [
	^ content
]

{ #category : #accessing }
EngineComponent >> content: anObject [
	content := anObject
]

{ #category : #accessing }
EngineComponent >> coordinatesSet [
	^ coordinatesSet
]

{ #category : #accessing }
EngineComponent >> coordinatesSet: anObject [
	coordinatesSet := anObject
]

{ #category : #example }
EngineComponent >> createFromCoordinates [
	<gtExample>
	
	| component |
	component := EngineComponent fromCoordinates: {4@6 . 5@6 . 6@6} withContent: 123.
	^ component
]

{ #category : #accessing }
EngineComponent >> getAdjacentCoordinates [
	^ (coordinatesSet flatCollectAsSet: [ :c | c eightNeighbors ]) difference: coordinatesSet
]

{ #category : #hashing }
EngineComponent >> hash [
	self coordinatesSet hash + self content hash
]

{ #category : #'as yet unclassified' }
EngineComponent >> printOn: aStream [
	aStream nextPutAll: 'EngineComponent ('.
	content printOn: aStream.
	aStream nextPutAll: ', '.
	coordinatesSet printOn: aStream.
	aStream nextPut: $).
]

{ #category : #example }
EngineComponent >> surroundingCoordinates [
	<gtExample>
	
	| component |
	component := self createFromCoordinates.
	self assert: component getAdjacentCoordinates equals: {3@5 . 4@5 . 5@5 . 6@5 . 7@5 . 3@6 . 7@6 . 3@7 . 4@7 . 5@7 . 6@7 . 7@7} asSet.
	^ component
]
